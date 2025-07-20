import type { ListItemData } from './ListItemData';

/**
 * Category item information.
 */
export interface  Category {

  /**
   * Category title.
   */
  title: Resource;

  /**
   * Category content(a list).
   */
  categoryContent: Array<ListItemData>;
}