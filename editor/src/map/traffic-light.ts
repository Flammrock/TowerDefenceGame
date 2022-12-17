/** *******************************************************************************\
* Copyright (c) 2022 - Lemmy Briot (Flammrock)                                    *
*                                                                                 *
* Permission is hereby granted, free of charge, to any person obtaining a copy    *
* of this software and associated documentation files (the "Software"), to deal   *
* in the Software without restriction, including without limitation the rights    *
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell       *
* copies of the Software, and to permit persons to whom the Software is           *
* furnished to do so, subject to the following conditions:                        *
*                                                                                 *
* The above copyright notice and this permission notice shall be included in all  *
* copies or substantial portions of the Software.                                 *
*                                                                                 *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR      *
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,        *
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE     *
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER          *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,   *
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE   *
* SOFTWARE.                                                                       *
\*********************************************************************************/

import Point from '../core/point'
import Base from './base'

export class TrafficLight extends Base {
  private position: Point
  private roadIndex: number
  private delayR: number // red
  private delayA: number // amber
  private delayG: number // green
  private dephase: number
  static get Zero () { return new TrafficLight(Point.Zero, 0, 0, 0, 0, 0) }
  constructor (position: Point, roadIndex: number, delayR: number, delayA: number, delayG: number, dephase: number) {
    super()
    this.position = Point.duplicate(position)
    this.roadIndex = roadIndex
    this.delayR = delayR
    this.delayA = delayA
    this.delayG = delayG
    this.dephase = dephase
  }

  toString (): string {
    return `${this.roadIndex} ${this.position.x} ${this.position.y} ${this.delayR} ${this.delayA} ${this.delayG} ${this.dephase}\n`
  }
}

export default TrafficLight
