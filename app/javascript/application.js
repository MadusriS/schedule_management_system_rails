import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('turbo:load', function() {
  const dayButtons = document.querySelectorAll(".day-button");
  dayButtons.forEach(function(button) {
    button.addEventListener("click", function() {
      const day = this.dataset.day;
      const scheduleContainer = document.getElementById(`${day.toLowerCase()}-schedule`);
      const allScheduleContainers = document.querySelectorAll(".day-schedule");
      allScheduleContainers.forEach(function(container) {
        container.style.display = "none";
      });
      scheduleContainer.style.display = "block";

      // Remove active class from all day buttons
      dayButtons.forEach(function(btn) {
        btn.classList.remove("active");
      });

      // Add active class to clicked day button
      this.classList.add("active");
    });
  });

  // Handle the Add Schedule button functionality
  const addScheduleButton = document.querySelector(".add-schedule-button");
  if (addScheduleButton) {
    addScheduleButton.addEventListener("click", function(event) {
      event.preventDefault();
      Turbo.visit(this.href);
    });
  }

  // Custom confirmation for actions like delete
  document.addEventListener('click', function(event) {
    let element = event.target.closest('[data-confirm]');
    if (!element) return;

    const confirmMessage = element.getAttribute('data-confirm');
    if (confirmMessage && !window.confirm(confirmMessage)) {
      event.preventDefault(); // Prevent the link or button from performing its action
      return false; // Stop further processing
    }

    // Handle form submission for delete operations
    if (element.matches('[data-method="delete"]')) {
      event.preventDefault(); // Prevent the link default GET behavior
      let action = element.getAttribute('href');
      let method = element.getAttribute('data-method');

      // Create and submit a form for the delete action
      const form = document.createElement('form');
      form.style.display = 'none';
      form.method = 'post';
      form.action = action;
      form.dataset.turboFrame = "_top"; // Ensure Turbo handles the form

      const methodInput = document.createElement('input');
      methodInput.type = 'hidden';
      methodInput.name = '_method';
      methodInput.value = method;

      const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
      const csrfInput = document.createElement('input');
      csrfInput.type = 'hidden';
      csrfInput.name = 'authenticity_token';
      csrfInput.value = csrfToken;

      form.appendChild(methodInput);
      form.appendChild(csrfInput);
      document.body.appendChild(form);
      form.submit();
    }
  });
});

