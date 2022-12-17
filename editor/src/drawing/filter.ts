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

import Collection from '../core/collection'
import { Serializable } from '../core/object-mapper'
import Renderable, { RenderableEvents } from './renderable'

/**
 * Allow to add effects on a {@link CanvasRenderingContext2D | Context} based on a set of {@link Renderable | Renderables}
 *
 * @example
 * ```
 * export class MyFilter implements Filter {
 *  apply (ctx: CanvasRenderingContext2D, items: Item<unknown>[]): void {
 *    // you code here
 *  }
 * }
 * ```
 *
 * @see [Filterable](./filterable.ts)
 * @see [RoadFilter](../engine/road-filter.ts)
 */
export interface Filter extends Serializable {

  /**
   * Apply effects on the target {@link CanvasRenderingContext2D | Context}
   *
   * @param ctx a {@link CanvasRenderingContext2D | Context}
   * @param items a collection of {@link Renderable | Renderables}
   */
  apply <T extends RenderableEvents> (ctx: CanvasRenderingContext2D, items: Collection<Renderable<T>>): void
}

export default Filter
