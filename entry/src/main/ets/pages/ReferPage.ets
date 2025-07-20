import router from '@ohos.router';
import { Card } from '../common/bean/NavItem';
import { BreakpointSystem, BreakpointState } from '../common/breakpoint/breakpointsystem'

/**
 * Detail page to display more information.
 */
@Entry
@Component
export struct ReferPage {
  private controller: TabsController = new TabsController()
  private swiperController: SwiperController = new SwiperController()
  @State headerSliderX: BreakpointState<Length> = BreakpointState.of({ sm: "0%", md: "91%", lg: "91%" })
  @State headerSearchX: BreakpointState<Length> = BreakpointState.of({ sm: "9%", md: "0%", lg: "0%" })
  @State headerSearchWidth: BreakpointState<Length> = BreakpointState.of({ sm: "85%", md: "40%", lg: "40%" })
  @State currentIndex: number = 0
  @State tabPosition: BreakpointState<boolean> = BreakpointState.of({ sm: false, md: true, lg: true })
  @State refers: Card[] = [
    {
      backImage: 'http://p2.music.126.net/AO9z3oVO24YpvrrJuez0Cw==/109951171342359629.jpg?param=140y140',
      svg: $r("app.media.rank"),
      title1: "热歌榜",
      title2: "云音乐官方top榜"
    },
    {
      backImage: 'http://p1.music.126.net/EGrmZoSgGXAsMKq0Wwbhlg==/109951170614898959.jpg?param=140y140',
      svg: $r("app.media.canlender"),
      title1: "每日推荐",
      title2: "今日限定好歌推荐"
    },
    {
      backImage: 'http://p1.music.126.net/kwVkoEKZOdJ75sJ3-VkLeQ==/109951171456693757.jpg?param=140y140',
      svg: $r("app.media.circle"),
      title1: "场景漫游",
      title2: "多样场景无限畅听"
    },
    {
      backImage: 'http://p2.music.126.net/uKZWPjFOFgL-MhmcW7dqYw==/109951171009440811.jpg?param=140y140',
      svg: $r("app.media.die"),
      title1: "场景漫游",
      title2: "多样场景无限畅听"
    }

  ]
  @State category: Card[] = [
    {
      backImage: "http://p1.music.126.net/Do7cil27exwEB5iwwP7YWQ==/109951169078154034.jpg?imageView=1&thumbnail=800y800&enlarge=1%7CimageView=1&watermark&type=1&image=b2JqL3c1bkRrTUtRd3JMRGpEekNtOE9tLzMxNjg5ODI0MTIzL2EyMGQvMjAyMzEwMjMxNzExNDQveDI3MzE3MDA3MzA3MDQzNDMucG5n&dx=0&dy=0%7Cwatermark&type=1&image=b2JqL3dvbkRsc0tVd3JMQ2xHakNtOEt4LzI3NjEwNDk3MDYyL2VlOTMvOTIxYS82NjE4LzdhMDc5ZDg0NTYyMDAwZmVkZWJmMjVjYjE4NjhkOWEzLnBuZw==&dx=0&dy=0%7CimageView=1&thumbnail=140y140&?param=140y140",
      svg: $r("app.media.die"),
      title1: "场景漫游",
      title2: "多样场景无限畅听"
    },
    {
      backImage: "http://p1.music.126.net/KGJgB364FdOfFjvlQCFTPg==/109951168968318913.jpg?imageView=1&thumbnail=800y800&enlarge=1%7CimageView=1&watermark&type=1&image=b2JqL3c1bkRrTUtRd3JMRGpEekNtOE9tLzM2NjM3MDMwNjMzL2Q4MmMvMjAyNDUxMzE3MjE4L3g5NTQxNzE4MjcwNDY4ODU4LnBuZw==&dx=0&dy=0%7Cwatermark&type=1&image=b2JqL3dvbkRsc0tVd3JMQ2xHakNtOEt4LzI3NjEwNDk3MDYyL2VlOTMvOTIxYS82NjE4LzdhMDc5ZDg0NTYyMDAwZmVkZWJmMjVjYjE4NjhkOWEzLnBuZw==&dx=0&dy=0%7CimageView=1&thumbnail=140y140&?param=140y140",
      svg: $r("app.media.die"),
      title1: "伤感",
      title2: "节奏布鲁斯精选"
    },
    {
      backImage: "http://p1.music.126.net/wWN6nfZKYYpjy90u6Xxyeg==/109951171074629129.jpg?imageView=1&thumbnail=800y800&enlarge=1%7CimageView=1&watermark&type=1&image=b2JqL3c1bkRrTUtRd3JMRGpEekNtOE9tLzYwMjIzMDYyNzYwLzJmNWUvMjAyNTQyODE0NTU1L3gzNTAxNzQ4NDE1MzA1NDI2LnBuZw==&dx=0&dy=0%7Cwatermark&type=1&image=b2JqL3dvbkRsc0tVd3JMQ2xHakNtOEt4LzI3NjEwNDk3MDYyL2VlOTMvOTIxYS82NjE4LzdhMDc5ZDg0NTYyMDAwZmVkZWJmMjVjYjE4NjhkOWEzLnBuZw==&dx=0&dy=0%7CimageView=1&thumbnail=140y140&?param=140y140",
      svg: $r("app.media.die"),
      title1: "R&B",
      title2: "一个人的心碎独白"
    },
    {
      backImage: "http://p1.music.126.net/Ggz8Mx-gXMJDzZ2M7_xz0g==/109951171263989642.jpg?imageView=1&thumbnail=800y800&enlarge=1%7CimageView=1&watermark&type=1&image=b2JqL3c1bkRrTUtRd3JMRGpEekNtOE9tLzYwNDA2Mjg3ODA5LzA0NTIvMjAyNTU1MTYyODMveDM1MTE3NDkxMTIwODM5MjAucG5n&dx=0&dy=0%7Cwatermark&type=1&image=b2JqL3dvbkRsc0tVd3JMQ2xHakNtOEt4LzI3NjEwNDk3MDYyL2VlOTMvOTIxYS82NjE4LzdhMDc5ZDg0NTYyMDAwZmVkZWJmMjVjYjE4NjhkOWEzLnBuZw==&dx=0&dy=0%7CimageView=1&thumbnail=140y140&?param=140y140",
      svg: $r("app.media.die"),
      title1: "emo天花板",
      title2: "一首情歌一段回忆"
    },
    {
      backImage: "http://p1.music.126.net/94qJyVfblmYN5ieAdgq8Dw==/109951168618369692.jpg?imageView=1&thumbnail=800y800&enlarge=1%7CimageView=1&watermark&type=1&image=b2JqL3c1bkRrTUtRd3JMRGpEekNtOE9tLzU4NjU0MDYzNDc0L2E2MTIvMjAyNTIxMDExMzAzOC94NjkxMTc0MTU3NzQzODczMi5wbmc=&dx=0&dy=0%7Cwatermark&type=1&image=b2JqL3dvbkRsc0tVd3JMQ2xHakNtOEt4LzI3NjEwNDk3MDYyL2VlOTMvOTIxYS82NjE4LzdhMDc5ZDg0NTYyMDAwZmVkZWJmMjVjYjE4NjhkOWEzLnBuZw==&dx=0&dy=0%7CimageView=1&thumbnail=140y140&?param=140y140",
      svg: $r("app.media.die"),
      title1: "放松",
      title2: "享受chill的治愈时刻"
    },
    {
      backImage: "http://p1.music.126.net/-fajwTbGnIxK-C18TUmxTg==/109951169874898636.jpg?imageView=1&thumbnail=800y800&enlarge=1%7CimageView=1&watermark&type=1&image=b2JqL3c1bkRrTUtRd3JMRGpEekNtOE9tLzU3ODIxNDk5Njg2LzU4N2IvMjAyNTAyMzE4MjAzMS94MTA3MTczNzYyNzYzMDk1Mi5wbmc=&dx=0&dy=0%7Cwatermark&type=1&image=b2JqL3dvbkRsc0tVd3JMQ2xHakNtOEt4LzI3NjEwNDk3MDYyL2VlOTMvOTIxYS82NjE4LzdhMDc5ZDg0NTYyMDAwZmVkZWJmMjVjYjE4NjhkOWEzLnBuZw==&dx=0&dy=0%7CimageView=1&thumbnail=140y140&?param=140y140",
      svg: $r("app.media.die"),
      title1: "电音",
      title2: "电子迷幻，灵魂出窍"
    },
    {
      backImage: "http://p1.music.126.net/2AYDfMr1YmQpZpqHnPzAww==/109951168618347011.jpg?imageView=1&thumbnail=800y800&enlarge=1%7CimageView=1&watermark&type=1&image=b2JqL3c1bkRrTUtRd3JMRGpEekNtOE9tLzU3ODM3NDk1OTEzLzcwMmUvMjAyNTAyNDE1MTgxMC94NzQzMTczNzcwMzA5MDE0MC5wbmc=&dx=0&dy=0%7Cwatermark&type=1&image=b2JqL3dvbkRsc0tVd3JMQ2xHakNtOEt4LzI3NjEwNDk3MDYyL2VlOTMvOTIxYS82NjE4LzdhMDc5ZDg0NTYyMDAwZmVkZWJmMjVjYjE4NjhkOWEzLnBuZw==&dx=0&dy=0%7CimageView=1&thumbnail=140y140&?param=140y140",
      svg: $r("app.media.die"),
      title1: "华语说唱",
      title2: "年度说唱舞台"
    },
    {
      backImage: "http://p1.music.126.net/BrF1aXmgMlKR3StGJNTZuQ==/109951168650432773.jpg?imageView=1&thumbnail=800y800&enlarge=1%7CimageView=1&watermark&type=1&image=b2JqL3c1bkRrTUtRd3JMRGpEekNtOE9tLzI4NzMyMjgzMzIwL2IxOGEvMjAyMzUxNDExMzgzMS94NDQ0MTY4NjcxMzkxMTEzMy5wbmc=&dx=0&dy=0%7Cwatermark&type=1&image=b2JqL3dvbkRsc0tVd3JMQ2xHakNtOEt4LzI3NjEwNDk3MDYyL2VlOTMvOTIxYS82NjE4LzdhMDc5ZDg0NTYyMDAwZmVkZWJmMjVjYjE4NjhkOWEzLnBuZw==&dx=0&dy=0%7CimageView=1&thumbnail=140y140&?param=140y140",
      svg: $r("app.media.die"),
      title1: "2000年代",
      title2: "2000年代专属"
    }

  ]

  aboutToAppear() {
    BreakpointSystem.getInstance().attach(this.tabPosition)
    BreakpointSystem.getInstance().attach(this.headerSliderX)
    BreakpointSystem.getInstance().attach(this.headerSearchX)
    BreakpointSystem.getInstance().attach(this.headerSearchWidth)
    BreakpointSystem.getInstance().start()
  }

  aboutToDisappear() {
    BreakpointSystem.getInstance().detach(this.tabPosition)
    BreakpointSystem.getInstance().detach(this.headerSliderX)
    BreakpointSystem.getInstance().detach(this.headerSearchX)
    BreakpointSystem.getInstance().detach(this.headerSearchWidth)
    BreakpointSystem.getInstance().stop()
  }

  @Builder
  TabTextBuilder(text: string, index: number) {
    Text(text)
      .fontSize(this.currentIndex === index ? 18 : 16)
      .fontColor(this.currentIndex === index ? '#000' : '#888')
      .fontWeight(this.currentIndex === index ? 800 : 400)
  }

  //推荐页
  @Builder
  TabMyContent() {

    Scroll() {

      Column() {
        if (!this.tabPosition.value) {
          Swiper(this.swiperController) {
            Image('https://p5.music.126.net/obj/wonDlsKUwrLClGjCm8Kx/61128846325/f308/a055/00cc/2d183d55769771e2acb556d911715e2c.jpg?imageView&quality=89')
              .width(349)
              .height(145)
              .borderRadius(10)
            Image('https://p5.music.126.net/obj/wonDlsKUwrLClGjCm8Kx/61140538568/1034/ffb9/b43f/d16a21bc00f1c60e052c87401d66da60.jpg?imageView&quality=89')
              .width(349)
              .height(145)
              .borderRadius(10)
            Image('http://p1.music.126.net/lP1H_mfrmEeO0A9_oi-4WA==/109951169072752079.jpg')
              .width(349)
              .height(145)
              .borderRadius(10)
          }
          .width(355)
          .height(145)
          .loop(true)
          .autoPlay(true)
        }


        Column() {
          Text(this.tabPosition.value?"下午好":"精选推荐")
            .fontSize(18)
            .fontColor('#000')
            .fontWeight(800)
            .margin({ bottom: 4 })
          GridRow({ gutter: { x: 6, y: 12 } }) {

            ForEach(this.refers, (item: Card, index: number) => {
              GridCol({
                span: {
                  xs: 12,
                  sm: 6,
                  md: 3,
                  lg: 3
                }
              }) {
                Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
                  RelativeContainer() {
                    Image(item.backImage)
                      .borderRadius(8)
                      .linearGradientBlur(60, {
                        fractionStops: [[0, 0], [0, 0.33], [1, 0.66], [1, 1]],
                        direction: GradientDirection.Left
                      })
                    Column({ space: 3 }) {
                      Image(item.svg)
                        .width(30)
                        .offset({
                          x: -70,
                          y: -30
                        })
                      Text(item.title1)
                        .fontWeight(FontWeight.Bold)
                        .fontColor("#FFFFFF")
                        .fontSize(20)
                        .textAlign(TextAlign.Start)
                        .width("100%")
                      Text(item.title2)
                        .fontWeight(FontWeight.Normal)
                        .fontColor("#ffe9e9e9")
                        .fontSize(13)
                        .textAlign(TextAlign.Start)
                        .width("100%")
                    }
                    .height("100%")
                    .offset({
                      y: 38,
                      x: 6
                    })

                  }
                  .width(175)
                  .height(120)

                }

              }
            })


          }

        }.width('100%')
        .padding({ left: 8, top: 6, right: 8 })
        .alignItems(HorizontalAlign.Start)


        Column() {
          Text('为你专属推荐')
            .fontSize(18)
            .fontColor('#000')
            .fontWeight(800)
            .margin({ bottom: 4 })
          GridRow({ gutter: { x: 4, y: 8 } }) {
            ForEach(this.category, (item: Card, index: number) => {
              GridCol({
                span: {
                  xs: 12,
                  sm: 6,
                  md: 3,
                  lg: 3
                }
              }) {
                Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
                  RelativeContainer() {
                    Image(item.backImage)
                      .borderRadius(8)
                      .linearGradientBlur(60, {
                        fractionStops: [[0, 0], [0, 0.33], [1, 0.66], [1, 1]],
                        direction: GradientDirection.Left
                      })
                    Column({ space: 3 }) {
                      Text(item.title1)
                        .fontWeight(FontWeight.Bold)
                        .fontColor("#FFFFFF")
                        .fontSize(20)
                        .textAlign(TextAlign.Start)
                        .width("100%")
                      Text(item.title2)
                        .fontWeight(FontWeight.Normal)
                        .fontColor("#ffe9e9e9")
                        .fontSize(15)
                        .textAlign(TextAlign.Start)
                        .width("100%")
                    }
                    .height("100%")
                    .offset({
                      y: 65,
                      x: 6
                    })

                  }
                  .width(175)
                  .height(120)

                }

              }

            })
          }

        }
        .width('100%')
        .padding({ left: 8, top: 6, right: 8 })
        .alignItems(HorizontalAlign.Start)
      }
    }
  }

  build() {
    Column() {
      RelativeContainer() {
        Image($r("app.media.slider"))
          .width(25)
          .offset({
            y: 6,
            x: this.headerSliderX.value
          })
        Search({ placeholder: "大家都在搜 我们的明天" })
          .width(this.headerSearchWidth.value)
          .margin({
            bottom: 10,
            right: 0,
            top: 0,
            left: 0
          })
          .offset({
            x: this.headerSearchX.value
          })
        Image($r("app.media.mic"))
          .width(25)
          .offset({
            x: `94%`,
            y: 6
          })


      }
      .padding({ left: 8, right: 8 })
      .height(40)
      // .margin({bottom:this.marGin.value})




      if (this.tabPosition.value) {
        this.TabMyContent()
      } else {
        Tabs({ index: this.currentIndex, controller: this.controller }) {
          TabContent() {
            this.TabMyContent()
          }
          .tabBar(this.TabTextBuilder('推荐', 0))
          .align(Alignment.TopStart)

          TabContent() {
            Text('首页的内容')
          }
          .tabBar(this.TabTextBuilder('音乐', 1))

          TabContent() {
            Text('推荐的内容').fontSize(35).fontColor('#888')
          }
          .tabBar(this.TabTextBuilder('博客', 2))

          TabContent() {
            Scroll() {
              Column() {
                Flex({
                  direction: FlexDirection.Row,
                  justifyContent: FlexAlign.SpaceAround,
                  alignItems: ItemAlign.Center
                }) {
                  Column() {
                    Image($r('app.media.nav_icon1'))
                      .width(43)
                      .height(43)
                      .margin({ bottom: 9 })
                    Text('每日推荐').fontSize(12).fontColor('#000')
                  }
                  .onClick(() => {
                    console.log("Daliy")
                    router.pushUrl({
                      url: 'pages/DailyRecommendPage'
                    })
                  })

                  Column() {
                    Image($r('app.media.nav_icon1'))
                      .width(43)
                      .height(43)
                      .margin({ bottom: 9 })
                    Text('歌单').fontSize(12).fontColor('#000')
                  }

                  Column() {
                    Image($r('app.media.nav_icon1'))
                      .width(43)
                      .height(43)
                      .margin({ bottom: 9 })
                    Text('排行榜').fontSize(12).fontColor('#000')
                  }

                  Column() {
                    Image($r('app.media.nav_icon1'))
                      .width(43)
                      .height(43)
                      .margin({ bottom: 9 })
                    Text('电台').fontSize(12).fontColor('#000')
                  }
                }
                .height(98)
                .margin({ top: 9 })

                Column() {
                  Flex({
                    direction: FlexDirection.Row,
                    justifyContent: FlexAlign.SpaceBetween,
                    alignItems: ItemAlign.Center
                  }) {
                    Text('推荐歌单')
                      .fontSize(16)
                      .fontColor('#000')
                      .fontWeight(800)
                    Text('歌单广场')
                      .padding({
                        top: 2,
                        right: 6,
                        bottom: 2,
                        left: 2
                      })
                      .border({ width: 1, color: '#ccc' })
                      .borderRadius(18)
                      .fontSize(10)
                      .fontColor('#000')
                  }
                  .padding({ left: 9, right: 9 })

                  Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceAround }) {
                    Column() {
                      Image('https://p1.music.126.net/LIhxL7p5UkYX5NmHL8vhzQ==/18869818556322650.jpg')
                        .width(107)
                        .margin({ bottom: 4 })
                      Text('听一首把自己感动的歌').fontSize(12).fontColor('#000')
                    }
                    .width(107)
                    .margin({ bottom: 13 })

                    Column() {
                      Image('https://p1.music.126.net/zpmOTZw533nltCQJtXC8Rg==/109951168215962168.jpg')
                        .width(107)
                        .margin({ bottom: 4 })
                      Text('我知道风里有诗，那正是民谣的歌').fontSize(12).fontColor('#000')
                    }
                    .width(107)
                    .margin({ bottom: 13 })

                    Column() {
                      Image('https://p1.music.126.net/qA0W0aER7LxB99iTOMQZcA==/109951166153828602.jpg')
                        .width(107)
                        .margin({ bottom: 4 })
                      Text('[国电新势力] 网易电子音乐人精选').fontSize(12).fontColor('#000')
                    }
                    .width(107)
                    .margin({ bottom: 13 })

                    Column() {
                      Image('https://p1.music.126.net/LIhxL7p5UkYX5NmHL8vhzQ==/18869818556322650.jpg')
                        .width(107)
                        .margin({ bottom: 4 })
                      Text('听一首把自己感动的歌').fontSize(12).fontColor('#000')
                    }
                    .width(107)
                    .margin({ bottom: 13 })

                    Column() {
                      Image('https://p1.music.126.net/zpmOTZw533nltCQJtXC8Rg==/109951168215962168.jpg')
                        .width(107)
                        .margin({ bottom: 4 })
                      Text('我知道风里有诗，那正是民谣的歌').fontSize(12).fontColor('#000')
                    }
                    .width(107)
                    .margin({ bottom: 13 })

                    Column() {
                      Image('https://p1.music.126.net/qA0W0aER7LxB99iTOMQZcA==/109951166153828602.jpg')
                        .width(107)
                        .margin({ bottom: 4 })
                      Text('[国电新势力] 网易电子音乐人精选').fontSize(12).fontColor('#000')
                    }
                    .width(107)
                    .margin({ bottom: 13 })
                  }
                  .margin({ top: 13 })
                }

                Column() {
                  Flex({
                    direction: FlexDirection.Row,
                    justifyContent: FlexAlign.SpaceBetween,
                    alignItems: ItemAlign.Center
                  }) {
                    Text('新碟')
                      .fontSize(16)
                      .fontColor('#000')
                      .fontWeight(800)
                    Text('更多新碟')
                      .padding({
                        top: 2,
                        right: 6,
                        bottom: 2,
                        left: 2
                      })
                      .border({ width: 1, color: '#ccc' })
                      .borderRadius(18)
                      .fontSize(10)
                      .fontColor('#000')
                  }
                  .padding({ left: 9, right: 9 })

                  Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceAround }) {
                    Column() {
                      Image('https://p1.music.126.net/Ik30xAtj2MQgCU5jE6K6Ww==/109951169052034633.jpg')
                        .width(107)
                        .margin({ bottom: 4 })
                      Text('暗流').fontSize(12).fontColor('#000')
                    }
                    .width(107)
                    .margin({ bottom: 13 })

                    Column() {
                      Image('https://p1.music.126.net/UGP6oPJ35Ab_mvBljtzoPA==/109951169067369971.jpg')
                        .width(107)
                        .margin({ bottom: 4 })
                      Text('도화').fontSize(12).fontColor('#000')
                    }
                    .width(107)
                    .margin({ bottom: 13 })

                    Column() {
                      Image('https://p1.music.126.net/AWcDI5wc9fkS2bZt6wIm-Q==/109951163212638897.jpg')
                        .width(107)
                        .margin({ bottom: 4 })
                      Text('Practice Make Perfect').fontSize(12).fontColor('#000')
                    }
                    .width(107)
                    .margin({ bottom: 13 })
                  }
                  .margin({ top: 13 })
                }

                Column() {
                  Flex({
                    direction: FlexDirection.Row,
                    justifyContent: FlexAlign.SpaceBetween,
                    alignItems: ItemAlign.Center
                  }) {
                    Text('最新MV')
                      .fontSize(16)
                      .fontColor('#000')
                      .fontWeight(800)
                    Text('查看更多')
                      .padding({
                        top: 2,
                        right: 6,
                        bottom: 2,
                        left: 2
                      })
                      .border({ width: 1, color: '#ccc' })
                      .borderRadius(18)
                      .fontSize(10)
                      .fontColor('#000')
                  }
                  .padding({ left: 9, right: 9 })

                  Column() {
                    Image('https://p1.music.126.net/qA0W0aER7LxB99iTOMQZcA==/109951166153828602.jpg')
                      .width(337)
                      .height(213)
                      .margin({ top: 9, bottom: 4 })
                      .borderRadius(12)
                    Text('덤더럼(Dumhdurum)')
                      .fontSize(16)
                      .fontColor('#000')
                      .fontWeight(800)
                      .height(42)
                      .margin({ left: 12 })
                  }
                  .borderRadius({ topLeft: 12, topRight: 12 })
                  .backgroundColor('#efefef')
                  .alignItems(HorizontalAlign.Start)
                  .width(337)
                  .margin({ bottom: 13 })

                  Flex({
                    direction: FlexDirection.Row,
                    justifyContent: FlexAlign.SpaceBetween,
                    alignItems: ItemAlign.Center
                  }) {
                    Row() {
                      Image($r('app.media.like'))
                        .width(17)
                        .height(20)
                      Text('220000')
                        .fontSize(16)
                        .fontColor('#000')
                        .margin({ left: 2, right: 4 })
                      Image($r('app.media.comment'))
                        .width(17)
                        .height(20)
                      Text('320000')
                        .fontSize(16)
                        .fontColor('#000')
                        .margin({ left: 2 })
                    }
                    .alignItems(VerticalAlign.Center)

                    Image($r('app.media.more_menu'))
                      .width(12)
                      .height(14)
                  }
                  .padding({ left: 20, right: 20 })
                }
              }
            }
          }
          .height('100%')
          .tabBar(this.TabTextBuilder('听书', 3))
        }
        .onChange((index: number) => {
          this.currentIndex = index
        })
        // .vertical(this.tabPosition.value)
        .width('100%')
        .height('100%')
        .scrollable(true)
      }

    }
    .justifyContent(FlexAlign.Start)
    .height("100%")
  }
}