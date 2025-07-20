import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';
import { DetailListComponent } from '../view/DetailListComponent';

/**
 * Detail page to display more information.
 */
@Entry
@Component
export struct HomePage {
  private titleParam: Resource = $r('app.string.detail_default_title');

  aboutToAppear() {
    // if (router.getParams()) {
    //   this.titleParam = router.getParams()[CommonConstants.KEY_PARAM_DATA] as Resource;
    // }
  }

  build() {
    Column() {
      Image($r('app.media.logo5'))
        .width('62')
        .height('62')
        .borderRadius('32')
        .margin({top:134})

      Column(){
        Text("网易云音乐 发现好音乐")
          .fontColor("#FFF2F3")
          .fontSize(18)
        Button('手机号登录')
          .width(282)
          .height(38)
          .borderRadius(50)
          .fontColor('#C20C0C')
          .backgroundColor('#fff')
          .margin({
            top:15
          })
        Button('立即体验')
          .width(282)
          .height(38)
          .borderRadius(50)
          .fontColor('#fff')
          .backgroundColor('transparent')
          .border({
            width:1,
            color:"#fff"
          })
          .margin({
            top:25
          })
          .onClick(()=>{
            router.pushUrl({
              url: CommonConstants.INDEX_PAGE
            });
            console.log('ok')
          })
        Row({space:6}){
          Divider()
            .color("#FF9891")
            .width(60)
          Text("网易云音乐支持 IPv6 网络")
            .fontSize(12)
            .fontColor("#FF9891")
          Divider()
            .color("#FF9891")
            .width(60)
        }
        .margin({top:20})

      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .position({
         x:0,
         y:'65%'
      })

    }
    .width('100%')
    .height(CommonConstants.DETAIL_COLUMN_HEIGHT_PERCENT)
    .backgroundColor($r('app.color.theme_background'))
  }
}

