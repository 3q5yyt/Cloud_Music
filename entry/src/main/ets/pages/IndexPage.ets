import { ReferPage } from './ReferPage'
import { HomePage } from './HomePage'
import { NavItem } from '../common/bean/NavItem'
import { BreakpointSystem, BreakpointState } from '../common/breakpoint/breakpointsystem'
import AVPlayerDemo from '../common/mediaPlayer/AVPlayerDemo'
import formatTime from '../common/constants/formatTime'

@Entry
@Component
struct IndexPage {
  @State tabWidth: BreakpointState<Length> = BreakpointState.of({ sm: "100%", md: "10%", lg: "10%" })
  @State tabPositionVertical: BreakpointState<boolean> = BreakpointState.of({ sm: false, md: true, lg: true })
  @State tabPosition: BreakpointState<BarPosition> =
    BreakpointState.of({ sm: BarPosition.End, md: BarPosition.Start, lg: BarPosition.Start })
  @State currentIndex: number = 0;
  @State navList: NavItem[] = [
    {
      activeIcon: $r('app.media.logo'),
      icon: $r('app.media.unlogo'),
      name: '推荐'
    },
    {
      activeIcon: $r('app.media.logo1'),
      icon: $r('app.media.unlogo1'),
      name: '漫游'
    },
    {
      activeIcon: $r('app.media.logo2'),
      icon: $r('app.media.unlogo2'),
      name: '笔记'
    },
    {
      activeIcon: $r('app.media.logo3'),
      icon: $r('app.media.unlogo3'),
      name: '我的'
    }
  ]
  @State songDuration: string = "";
  @StorageLink('trackId') trackId: string = '';
  @StorageLink('position') positionA: number = 0;
  @StorageLink('isPlaying') isPlaying: boolean = false;
  @StorageLink('playBlockPosition') playBlockPosition: number = 30;
  private avplayerController: AVPlayerDemo = new AVPlayerDemo();


  aboutToAppear() {

    BreakpointSystem.getInstance().attach(this.tabPosition)
    BreakpointSystem.getInstance().attach(this.tabWidth)
    BreakpointSystem.getInstance().attach(this.tabPositionVertical)
    BreakpointSystem.getInstance().start()
    this.avplayerController.init()
  }

  aboutToDisappear() {
    BreakpointSystem.getInstance().detach(this.tabPosition)
    BreakpointSystem.getInstance().detach(this.tabWidth)
    BreakpointSystem.getInstance().detach(this.tabPositionVertical)
    BreakpointSystem.getInstance().stop()

  }

  build() {
    Column() {


      Tabs({ barPosition: this.tabPosition.value }) {
        ForEach(this.navList, (item: NavItem, index: number) => {
          TabContent() {
            if (index == 0) {
              ReferPage()
            } else if (index == 1) {
              HomePage()
            } else if (index == 2) {
              ReferPage()
            } else if (index == 3) {
              ReferPage()
            }
          }.tabBar(this.TabsBuilder(item, index))

        })

      }.onChange((index: number) => {
        this.currentIndex = index;
      })
      .vertical(this.tabPositionVertical.value)
      .barWidth(this.tabWidth.value)

      this.Player()
    }

  }

  @Builder
  Player() {
    Column() {
      GridRow() {
        GridCol({ span: { sm: 12, md: 6, lg: 6 } }) {
          Column() {
            Row() {
              Image($r("app.media.pulldown"))
                .width(23)
                .onClick(() => {
                  this.playBlockPosition = 30;
                })
              Text("漫游模式")
                .fontColor("#A0AFB6")
                .fontSize(16)
              Image($r("app.media.share"))
                .width(23)
            }
            .offset({
              y:this.tabPositionVertical.value?100:0
            })
            .width("100%")
            .justifyContent(FlexAlign.SpaceBetween)

            Stack() {
              Circle()
                .width(285)
                .height(285)
                .fillOpacity(0)
                .strokeWidth(10)
                .stroke("#48575C")
              Image($r("app.media.disk"))
                .width(315)
              Image("https://p1.music.126.net/f0CcU4OcqJRg9v5At1qmAQ==/109951171389053450.jpg?param=130y130")
                .width(180)
                .height(180)
                .borderRadius(100)
            }
            .margin({ top: "38%" })

            Row() {
              Column({ space: 5 }) {
                Text("Run Free (Radio Edit)")
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor("#B2BDBF")
                Text("Deep Chills/IVIE")
                  .fontSize(17)
                  .fontWeight(FontWeight.Medium)
                  .fontColor("#7D888A")
              }
              .alignItems(HorizontalAlign.Start)

              Row({ space: 18 }) {
                Image($r("app.media.fav"))
                  .width(30)
                Image($r("app.media.msg"))
                  .width(30)
              }
            }.width("100%")
            .margin({ top: 20 })
            .justifyContent(FlexAlign.SpaceBetween)

            //------------------------------------------------------slider--------------------------//
            Slider({
              value: this.positionA,
              min: 0,
              max: this.avplayerController.avPlayer?.duration
            })
              .blockSize({ width: 10, height: 10 })
              .trackColor("#667071")
              .blockColor("#FBFFFF")
              .selectedColor("#A0AFB6")
              .trackThickness(3)
              .width("100%")
              .onChange((val) => {

                this.avplayerController.avPlayer?.seek(val)


              })
            Row() {
              Text(formatTime(this.positionA))
                .fontWeight(FontWeight.Medium)
                .fontColor("#657072")
              Text("标准")
                .fontWeight(FontWeight.Medium)
                .fontColor("#7D888A")
              Text(this.songDuration)
                .fontWeight(FontWeight.Medium)
                .fontColor("#657072")
            }
            .offset({
              y: -8
            })
            .width("100%")
            .justifyContent(FlexAlign.SpaceBetween)

            Row() {
              Image($r("app.media.circle_play"))
                .width(31)
              Image($r("app.media.last"))
                .width(25)
              Image(this.isPlaying ? $r("app.media.pause") : $r("app.media.play"))
                .width(33)//---------------------------------------------play--------------------------------//
                .onClick(() => {
                  this.isPlaying = !this.isPlaying;
                  if (this.isPlaying == false) {
                    this.avplayerController.avPlayer?.pause()
                  } else {
                    this.avplayerController.avPlayer?.play()
                  }
                })
              Image($r("app.media.next"))
                .width(25)
              Image($r("app.media.playlist"))
                .width(28)
            }
            .offset({
              y: 15
            })
            .width("100%")
            .justifyContent(FlexAlign.SpaceBetween)

          }.width("100%")
        }
      }
    }
    .backgroundColor("#43545B")
    .width("100%")
    .height("120%")
    .padding({ top:18, right: "5%", left: "5%" })
    .offset({
      y: this.playBlockPosition
      //30 -770
    })
    .animation({
      duration: 400,
      curve: Curve.EaseOut,
      playMode: PlayMode.Normal,
      onFinish: () => {
        if (this.playBlockPosition === -770 ||this.playBlockPosition === -745) {
          this.avplayerController.avPlayer?.play();
          this.isPlaying = true;
          this.songDuration = formatTime(this.avplayerController.avPlayer?.duration);
          //-------------------------------------------start play---------------------------------//
          this.avplayerController.avPlayer?.on('timeUpdate', (time: number) => {
            this.positionA = time;
          })
          this.avplayerController.avPlayer?.on('stateChange', (State: string) => {
            switch (State) {
              case 'completed':
                this.isPlaying = false;
                this.positionA = 0;
            }
          })
        }

      }
    })
  }

  @Builder
  TabsBuilder(item: NavItem, index: number) {
    Column({ space: 16 }) {
      Image(this.currentIndex == index ? item.activeIcon : item.icon)
        .width(25)
        .height(25)
      Text(item.name)
        .fontSize(12)
        .fontColor(this.currentIndex == index ? '#2c2c2c' : '#2C2C2C')

    }

  }
}