import { ReferPage } from './ReferPage'
import { HomePage } from './HomePage'
import { NavItem } from '../common/bean/NavItem'
import { BreakpointSystem, BreakpointState } from  '../common/breakpoint/breakpointsystem'

@Entry
@Component
struct IndexPage {
  @State tabWidth:BreakpointState<Length> = BreakpointState.of({sm:"100%",md:"10%",lg:"10%"})
  @State tabPositionVertical:BreakpointState<boolean> = BreakpointState.of({sm:false,md:true,lg:true})
  @State tabPosition:BreakpointState<BarPosition> = BreakpointState.of({sm:BarPosition.End,md:BarPosition.Start,lg:BarPosition.Start})
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

  aboutToAppear() {
    BreakpointSystem.getInstance().attach(this.tabPosition)
    BreakpointSystem.getInstance().attach(this.tabWidth)
    BreakpointSystem.getInstance().attach(this.tabPositionVertical)
    BreakpointSystem.getInstance().start()
  }
  aboutToDisappear(){
    BreakpointSystem.getInstance().detach(this.tabPosition)
    BreakpointSystem.getInstance().detach(this.tabWidth)
    BreakpointSystem.getInstance().detach(this.tabPositionVertical)
    BreakpointSystem.getInstance().stop()
  }

  build() {
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