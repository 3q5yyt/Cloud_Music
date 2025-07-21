import { AbilityConstant, Caller, common, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { distributedDataObject } from '@kit.ArkData';
import { distributedDeviceManager } from '@kit.DistributedServiceKit';
import { BusinessError } from '@kit.BasicServicesKit';
/**
 * Lift cycle management of Ability.
 */


// 业务数据定义
class Data {
  trackId: string | undefined;
  position: number | undefined;
  isPlaying: boolean | undefined;

  constructor(trackId: string | undefined, position: number | undefined, isPlaying: boolean | undefined) {
    this.trackId = trackId;
    this.position = position;
    this.isPlaying = isPlaying;
  }
}

const TAG = '[DistributedDataObject]';

let sessionId: string;
let caller: Caller;
let dataObject: distributedDataObject.DataObject;

export default class EntryAbility extends UIAbility {
  // 1. 调用端调用startAbilityByCall接口拉起对端Ability
  callRemote() {
    if (caller) {
      console.error(TAG + 'call remote already');
      return;
    }
    let context = getContext(this) as common.UIAbilityContext;

    // 1.1 调用genSessionId接口创建一个sessionId，通过分布式设备管理接口获取对端设备networkId
    sessionId = distributedDataObject.genSessionId();
    console.log(TAG + `gen sessionId: ${sessionId}`);
    let deviceId = getRemoteDeviceId();
    if (deviceId == "") {
      console.warn(TAG + 'no remote device');
      return;
    }
    console.log(TAG + `get remote deviceId: ${deviceId}`);

    // 1.2 组装want，并将sessionId放入want
    let want: Want = {
      bundleName: 'com.example.collaboration',
      abilityName: 'EntryAbility',
      deviceId: deviceId,
      parameters: {
        'ohos.aafwk.param.callAbilityToForeground': true, // 前台启动，非必须
        'distributedSessionId': sessionId
      }
    }
    try {
      // 1.3 调用startAbilityByCall接口拉起对端Ability
      context.startAbilityByCall(want).then((res) => {
        if (!res) {
          console.error(TAG + 'startAbilityByCall failed');
        }
        caller = res;
      })
    } catch (e) {
      let err = e as BusinessError;
      console.error(TAG + `get remote deviceId error, error code: ${err.code}, error message: ${err.message}`);
    }
  }

  // 2. 拉起对端Ability后创建分布式数据对象
  createDataObject() {
    if (!caller) {
      console.error(TAG + 'call remote first');
      return;
    }
    if (dataObject) {
      console.error(TAG + 'create dataObject already');
      return;
    }
    let context = getContext(this) as common.UIAbilityContext;

    // 2.1 创建分布式数据对象实例
    let data = new Data(AppStorage.get("trackId") as string, AppStorage.get("position") as number,
      AppStorage.get("isPlaying") as boolean);
    dataObject = distributedDataObject.create(context, data);

    // 2.2 注册数据变更监听
    dataObject.on('change', (sessionId: string, fields: Array<string>) => {
      fields.forEach((field) => {
        console.log(TAG + `${field}: ${dataObject[field]}`);
      });
    });
    // 2.3 设置同步sessionId加入组网
    dataObject.setSessionId(sessionId);
  }


  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    this.callRemote();
    if (want.parameters && want.parameters.distributedSessionId) {
      // 3.1 创建分布式数据对象实例
      let data = new Data(undefined, undefined, undefined);
      dataObject = distributedDataObject.create(this.context, data);
      // 3.2 注册数据变更监听
      dataObject.on('change', (sessionId: string, fields: Array<string>) => {
        fields.forEach((field) => {
          console.log(TAG + `${field}: ${dataObject[field]}`);
        });
      });
      AppStorage.setOrCreate('trackId', dataObject['trackId']);
      AppStorage.setOrCreate('position', dataObject['position']);
      AppStorage.setOrCreate('isPlaying', dataObject['isPlaying']);


      // 3.3 从want中获取源端放入的sessionId，使用这个sessionId加入组网
      let sessionId = want.parameters.distributedSessionId as string;
      console.log(TAG + `onCreate get sessionId: ${sessionId}`);
      dataObject.setSessionId(sessionId);
    }

  }

  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.callRemote();
    if (want.parameters && want.parameters.distributedSessionId) {
      // 3.1 创建分布式数据对象实例
      let data = new Data(undefined, undefined, undefined);
      dataObject = distributedDataObject.create(this.context, data);
      // 3.2 注册数据变更监听
      dataObject.on('change', (sessionId: string, fields: Array<string>) => {
        fields.forEach((field) => {
          console.log(TAG + `${field}: ${dataObject[field]}`);
        });
      });
      AppStorage.setOrCreate('trackId', dataObject['trackId']);
      AppStorage.setOrCreate('position', dataObject['position']);
      AppStorage.setOrCreate('isPlaying', dataObject['isPlaying']);


      // 3.3 从want中获取源端放入的sessionId，使用这个sessionId加入组网
      let sessionId = want.parameters.distributedSessionId as string;
      console.log(TAG + `onCreate get sessionId: ${sessionId}`);
      dataObject.setSessionId(sessionId);
    }
  }

  async onContinue(wantParam: Record<string, Object | undefined>): Promise<AbilityConstant.OnContinueResult> {
      this.createDataObject();
    return AbilityConstant.OnContinueResult.AGREE;
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent("pages/HomePage", (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}

// 获取可信组网中的设备
function getRemoteDeviceId() {
  let deviceId = "";
  try {
    let deviceManager = distributedDeviceManager.createDeviceManager('com.example.collaboration');
    let devices = deviceManager.getAvailableDeviceListSync();
    if (devices[0] && devices[0].networkId) {
      deviceId = devices[0].networkId;
    }
  } catch (e) {
    let err = e as BusinessError;
    console.error(TAG + `get remote deviceId error, error code: ${err.code}, error message: ${err.message}`);
  }
  return deviceId;
}