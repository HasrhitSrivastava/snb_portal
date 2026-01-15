import "flowbite"
import Rails from "@rails/ujs"

import "active_admin/features/batch_actions"
import "active_admin/features/dark_mode_toggle"
import "active_admin/features/has_many"
import "active_admin/features/filters"
import "active_admin/features/main_menu"
import "active_admin/features/per_page"

Rails.start()

function initSelect2() {
  if (typeof $ === "undefined" || typeof $.fn.select2 === "undefined") {
    console.warn("Select2 is not loaded")
    return
  }

  $(".select2").each(function () {
    const placeholder = $(this).data("placeholder") || "Select an option"

    $(this).select2({
      width: "100%",
      placeholder: placeholder,
      allowClear: true
    })
  })
}

document.addEventListener("DOMContentLoaded", initSelect2)
document.addEventListener("turbo:load", initSelect2)