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

import { CommonConstants as Const } from '../common/CommonConstants';
import { TopTabContent } from '../model/DataModel';
import { VideoSwiper } from '../view/VideoSwiper';

@Component
export struct ShortVideo {

  build() {
    Stack({ alignContent: Alignment.Top }) {
      VideoSwiper()
        .height(Const.FULL_SIZE)
    }
    .width(Const.FULL_SIZE)
    .height(Const.FULL_SIZE)
  }
}