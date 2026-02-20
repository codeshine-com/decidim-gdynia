$(function () {
  var $checkbox = $("input[name='user[card_number_possesion]']");
  var $cardNumberInput = $("input[name='user[card_number]']");

  if (!$checkbox.length || !$cardNumberInput.length) {
    return;
  }

  function updateCardNumberState() {
    if ($checkbox.is(":checked")) {
      $cardNumberInput.prop("disabled", false).prop("readonly", false);
    } else {
      $cardNumberInput.prop("disabled", true).val("");
    }
  }

  updateCardNumberState();
  $checkbox.on("change", updateCardNumberState);
});
