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

// custom password validation
$(function () {
  function checkPasswordStrength() {
    var passwordField = $(".password-field-js");
    if (!passwordField.length) return true;

    var text = passwordField.val() || "";

    var lengthEl = document.getElementById("length");
    var lowercaseEl = document.getElementById("lowercase");
    var uppercaseEl = document.getElementById("uppercase");
    var numberEl = document.getElementById("number");
    var specialEl = document.getElementById("special");

    var ruleSuccessClass = "password-rule-success";
    var ruleErrorClass = "password-rule-error";

    function setSuccessForRule(ruleElement) {
      if (!ruleElement) return;
      ruleElement.classList.add(ruleSuccessClass);
      ruleElement.classList.remove(ruleErrorClass);
      var textEl = ruleElement.querySelector(".password-rule-result-text");
      if (textEl) textEl.innerHTML = "";
    }

    function setErrorForRule(ruleElement) {
      if (!ruleElement) return;
      ruleElement.classList.remove(ruleSuccessClass);
      ruleElement.classList.add(ruleErrorClass);
      var textEl = ruleElement.querySelector(".password-rule-result-text");
      if (textEl) textEl.innerHTML = "";
    }

    var lenOk = checkIfTenChar(text);
    var lowOk = checkIfOneLowercase(text);
    var upOk = checkIfOneUppercase(text);
    var numOk = checkIfOneDigit(text);
    var specOk = checkIfOneSpecialChar(text);

    lenOk ? setSuccessForRule(lengthEl) : setErrorForRule(lengthEl);
    lowOk ? setSuccessForRule(lowercaseEl) : setErrorForRule(lowercaseEl);
    upOk ? setSuccessForRule(uppercaseEl) : setErrorForRule(uppercaseEl);
    numOk ? setSuccessForRule(numberEl) : setErrorForRule(numberEl);
    specOk ? setSuccessForRule(specialEl) : setErrorForRule(specialEl);

    return lenOk && lowOk && upOk && numOk && specOk;
  }

  function checkIfTenChar(text) {
    return text.length >= 10;
  }

  function checkIfOneLowercase(text) {
    return /[a-z]/.test(text);
  }

  function checkIfOneUppercase(text) {
    return /[A-Z]/.test(text);
  }

  function checkIfOneDigit(text) {
    return /[0-9]/.test(text);
  }

  function checkIfOneSpecialChar(text) {
    return /[~`!@#$%\^&*+=\-\[\]\\';,/{}|\\":<>\?]/g.test(text);
  }

  var passwordFieldEl = $(".password-field-js");
  if (passwordFieldEl.length) {
    checkPasswordStrength();
    passwordFieldEl.on("keyup input", checkPasswordStrength);

    $(".form-error.password-field-error-js").html(
      $(".form-error.password-field-hint-js").html(),
    );
    $(".form-error.password-field-hint-js").html("");

    passwordFieldEl.removeAttr(
      "required pattern minlength maxlength data-invalid aria-invalid aria-describedby",
    );

    $("#registration_user_password")
      .siblings(".form-error.is-visible")
      .hide()
      .text("");
  }

  var $registerForm = $("#register-form");
  if ($registerForm.length) {
    $registerForm.attr("novalidate", "novalidate");

    var submitSelector = "button[type=submit], input[type=submit]";
    var submitButtons = $registerForm.find(submitSelector).toArray();

    function isSubmitClickTarget(target) {
      if (!target) return false;
      var el = target.closest ? target.closest(submitSelector) : null;
      if (!el) return false;
      return submitButtons.indexOf(el) !== -1;
    }

    var captureClickHandler = function (e) {
      try {
        if (isSubmitClickTarget(e.target)) {
          var okClick = checkPasswordStrength();
          if (!okClick) {
            e.preventDefault();
            e.stopImmediatePropagation();
            var pw = passwordFieldEl.get(0);
            if (pw) {
              pw.scrollIntoView({ behavior: "smooth", block: "center" });
              pw.focus();
            }
            return false;
          }
        }
      } catch (err) {
        console.error(err);
      }
    };

    document.addEventListener("click", captureClickHandler, true);

    $registerForm.on("submit", function (e) {
      var ok = checkPasswordStrength();
      if (!ok) {
        e.preventDefault();
        e.stopImmediatePropagation();
        var pw = passwordFieldEl.get(0);
        if (pw) {
          pw.scrollIntoView({ behavior: "smooth", block: "center" });
          pw.focus();
        }
        return false;
      } else {
        $(".form-error.password-field-error-js").hide().text("");
      }
    });
  }
});
