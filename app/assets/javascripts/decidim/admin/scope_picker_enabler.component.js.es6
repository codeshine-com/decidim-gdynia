$(() => {
  ((exports) => {
    const $ComponentScopeEnabled = $("#component_settings_scopes_enabled");
    const $ComponentScopeId = $("#component_settings_scope_id");

    if ($(".edit_component, .new_component").length > 0) {
      $ComponentScopeEnabled.on("change", (event) => {
        const checked = event.target.checked;
        exports.theDataPicker.enabled($ComponentScopeId, checked);
        $ComponentScopeId.attr('disabled', !checked);
      })
      exports.theDataPicker.enabled($ComponentScopeId, $ComponentScopeEnabled.prop("checked"));
    }

    if (!($ComponentScopeEnabled.prop("checked"))) {
      $ComponentScopeId.attr('disabled', true);
    }
  })(window);
});
