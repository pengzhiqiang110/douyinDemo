/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { initTabTuData } from '../viewmodel/TabViewModel';
import { BottomTabModel } from '../viewmodel/TabItem';
import { Constants } from '../common/Constants';
import { VideoTabContent } from '../view/VideoTabContent';
import { TopView } from '../view/TopView';
import { DrawerTab } from '../view/DraverTab';

@Entry
@Component
struct OstrichStyleTab {
  @State tabArray: Array<BottomTabModel> = initTabTuData();
  @State currentIndex: number = 0;
  @State iconOffset: number = 0;
  @State initNumber: number = 0;
  private controller: TabsController = new TabsController();

  @Builder
  Tab(selectImage: Resource, defaultImage: Resource, title: string, middleMode: boolean, index: number) {
    Column() {
      if (index === Constants.TAB_INDEX_TWO) {
        Image(defaultImage)
          .size({ width: Constants.IMAGE_SIZE_MIDDLE, height: Constants.IMAGE_SIZE_MIDDLE })
          .offset({ y: Constants.IMAGE_OFFSET })
      }
      // else {
      //   Image(this.currentIndex === index ? selectImage : defaultImage)
      //     .size({ width: Constants.IMAGE_SIZE_TAB, height: Constants.IMAGE_SIZE_TAB })
      //     .offset({
      //       y: (this.currentIndex === index && this.currentIndex !== Constants.TAB_INDEX_TWO)
      //         ? this.iconOffset : this.initNumber
      //     })
      //     .objectFit(ImageFit.Contain)
      //     .animation({
      //       duration: Constants.ANIMATION_DURATION,
      //       curve: Curve.Ease,
      //       playMode: PlayMode.Normal
      //     })
      // }

      if (!middleMode) {
        Text(title)
          .fontSize($r('app.float.tab_text_font_size'))
          .margin({ top: $r('app.float.margin_tab_text') })
          .fontColor(this.currentIndex === index ? Color.White : Color.Gray)
      }
    }
    .padding({ top: $r('app.float.padding_rudder_tab') })
    .width(Constants.FULL_WIDTH)
    .backgroundColor(Color.Black)
    .height($r('app.float.rudder_barHeight'))
    .translate({ y: Constants.TRANSLATE_BOTTOM })
    .onClick(() => {
      if (index !== Constants.TAB_INDEX_TWO) {
        this.currentIndex = index;
        this.controller.changeIndex(index);
        this.iconOffset = Constants.ICON_Offset;
      }
    })
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.BottomStart }) {
        Tabs({ barPosition: BarPosition.End, controller: this.controller }) {
          ForEach(this.tabArray, (item: BottomTabModel, index: number) => {
            if (index === Constants.TAB_INDEX_TWO) {
              TabContent() {
              }
              .backgroundColor(Color.White)
            } else {
              TabContent() {
                Row() {
                  if (index === 0) {
                    TopView()
                      .backgroundColor(Color.Black)
                  } else {
                    Text(item.title)
                      .fontSize($r('app.float.content_font_size'))
                  }
                }
                .height(Constants.FULL_HEIGHT)
                .width(Constants.FULL_WIDTH)
                .justifyContent(FlexAlign.Center)
              }
              .backgroundColor(Color.White)
            }
          }, (item: BottomTabModel, index: number) => JSON.stringify(item) + index)
        }
        .scrollable(false)
        .barHeight(this.initNumber)
        .animationDuration(Constants.ANIMATION_DURATION)

        Flex() {
          ForEach(this.tabArray, (item: BottomTabModel, index: number) => {
            this.Tab(item.selectImage, item.defaultImage, item.title, item.middleMode, index)
          }, (item: BottomTabModel, index: number) => JSON.stringify(item) + index)
        }
      }
    }
    .height(Constants.FULL_HEIGHT)
  }
}