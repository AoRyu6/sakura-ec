import { Controller } from "@hotwired/stimulus";
import { patch } from "@rails/request.js";
import Sortable from "sortablejs";

// Connects to data-controller="sortable"
export default class extends Controller {
  connect() {
    const options = {
      onEnd: this.onUpdate.bind(this),
    };
    this.sortable = new Sortable(this.element, options);
  }

  disconnect() {
    this.sortable.destroy();
    this.sortable = undefined;
  }

  async onUpdate(event) {
    const body = { row_order_position: event.newIndex };
    await patch(event.item.dataset.sortableUrl, { body: JSON.stringify(body) });
  }
}
