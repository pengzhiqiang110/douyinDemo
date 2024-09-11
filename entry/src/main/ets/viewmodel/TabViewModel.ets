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

import { TabItem, BottomTabModel, ClassifyModel } from './TabItem';

export function initTabData(): TabItem[] {
  let tabDataArray: TabItem[] = [];
  TabItemData.forEach((item: TabItem) => {
    tabDataArray.push(new TabItem(item.id, item.name));
  })
  return tabDataArray;
}

export function initHomeTabData(): TabItem[] {
  let tabDataArray: TabItem[] = [];
  HomeTabItemData.forEach((item: TabItem) => {
    tabDataArray.push(new TabItem(item.id, item.name));
  })
  return tabDataArray;
}

export function initTabTuData(): BottomTabModel[] {
  let tabTuDataArray: BottomTabModel[] = [];
  TabTuItemData.forEach((item: BottomTabModel) => {
    tabTuDataArray.push(new BottomTabModel(item.defaultImage, item.selectImage, item.title, item.middleMode));
  })
  return tabTuDataArray;
}

export function initSideData(): ClassifyModel[] {
  let tabDataArray: ClassifyModel[] = [];
  ClassifyData.forEach((item: ClassifyModel) => {
    tabDataArray.push(new ClassifyModel(item.classifyId, item.classifyName));
  })
  return tabDataArray;
}

const TabItemData: TabItem[] = [
  new TabItem(0, '关注'),
  new TabItem(1, '推荐'),
  new TabItem(2, '图书'),
  new TabItem(3, '小说'),
  new TabItem(4, '漫画'),
  new TabItem(5, '听书'),
  new TabItem(6, '交友'),
  new TabItem(7, '直播'),
  new TabItem(8, '视频')
];

const HomeTabItemData: TabItem[] = [
  new TabItem(0, '直播'),
  new TabItem(1, '精选'),
  new TabItem(2, '经验'),
  new TabItem(3, '同城'),
  new TabItem(4, '关注'),
  new TabItem(5, '商城'),
  new TabItem(6, '推荐')
];

const TabTuItemData: BottomTabModel[] = [
  new BottomTabModel($r('app.media.home'), $r('app.media.activeHome'), '首页'),
  new BottomTabModel($r('app.media.star'), $r('app.media.activeStar'), '朋友'),
  new BottomTabModel($r('app.media.activePlus'), $r('app.media.activePlus'), '', true),
  new BottomTabModel($r('app.media.message'), $r('app.media.activeMessage'), '消息'),
  new BottomTabModel($r('app.media.people'), $r('app.media.activePeople'), '我')
]

const ClassifyData: ClassifyModel[] = [
  new ClassifyModel(0, '热门课程'),
  new ClassifyModel(1, '最新课程'),
  new ClassifyModel(2, 'HarmonyOS'),
  new ClassifyModel(3, '精彩活动'),
  new ClassifyModel(4, '开发者说'),
  new ClassifyModel(5, '后端开发'),
  new ClassifyModel(6, '前端开发')
]