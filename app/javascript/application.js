// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('turbo:load', function() {
  // JavaScript code to handle display of schedule containers based on the selected day
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

  // JavaScript code to handle "Add Schedule" button functionality
  const addScheduleButton = document.querySelector(".add-schedule-button");
  if (addScheduleButton) {
    addScheduleButton.addEventListener("click", function(event) {
      event.preventDefault();
      // Redirect to the new schedule path
      Turbo.visit(this.href);
    });
  }
});
