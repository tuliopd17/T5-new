// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

// Library Management System JavaScript
document.addEventListener("DOMContentLoaded", function () {
  // Form validation enhancements
  initializeFormValidation();

  // Search functionality
  initializeSearch();

  // Interactive elements
  initializeInteractiveElements();

  // Auto-dismiss alerts
  autoDismissAlerts();

  // Loading states
  initializeLoadingStates();
});

// Form validation with custom styling
function initializeFormValidation() {
  const forms = document.querySelectorAll(".needs-validation");

  forms.forEach(function (form) {
    form.addEventListener("submit", function (event) {
      if (!form.checkValidity()) {
        event.preventDefault();
        event.stopPropagation();

        // Focus on first invalid field
        const firstInvalid = form.querySelector(":invalid");
        if (firstInvalid) {
          firstInvalid.focus();
          firstInvalid.scrollIntoView({ behavior: "smooth", block: "center" });
        }
      }
      form.classList.add("was-validated");
    });

    // Real-time validation feedback
    const inputs = form.querySelectorAll("input, select, textarea");
    inputs.forEach(function (input) {
      input.addEventListener("blur", function () {
        if (input.checkValidity()) {
          input.classList.remove("is-invalid");
          input.classList.add("is-valid");
        } else {
          input.classList.remove("is-valid");
          input.classList.add("is-invalid");
        }
      });
    });
  });
}

// Enhanced search with debouncing
function initializeSearch() {
  const searchInputs = document.querySelectorAll('input[name="search"]');

  searchInputs.forEach(function (input) {
    let timeout;

    input.addEventListener("input", function () {
      clearTimeout(timeout);

      // Add loading state
      input.classList.add("loading");

      timeout = setTimeout(function () {
        // Remove loading state after delay
        input.classList.remove("loading");

        // Auto-submit search form if user stops typing
        if (input.value.length >= 3 || input.value.length === 0) {
          const form = input.closest("form");
          if (form) {
            // Add subtle animation
            form.style.opacity = "0.7";
            setTimeout(() => (form.style.opacity = "1"), 300);
          }
        }
      }, 500);
    });

    // Search suggestions (simulate)
    input.addEventListener("focus", function () {
      // Could add dropdown with recent searches or suggestions
      input.setAttribute("placeholder", "Digite para buscar...");
    });

    input.addEventListener("blur", function () {
      input.setAttribute("placeholder", "Buscar...");
    });
  });
}

// Interactive elements and animations
function initializeInteractiveElements() {
  // Card hover effects
  const cards = document.querySelectorAll(".card");
  cards.forEach(function (card) {
    card.addEventListener("mouseenter", function () {
      card.style.transform = "translateY(-5px)";
    });

    card.addEventListener("mouseleave", function () {
      card.style.transform = "translateY(0)";
    });
  });

  // Button click effects
  const buttons = document.querySelectorAll(".btn");
  buttons.forEach(function (button) {
    button.addEventListener("click", function (e) {
      // Ripple effect
      const ripple = document.createElement("span");
      const rect = button.getBoundingClientRect();
      const size = Math.max(rect.width, rect.height);
      const x = e.clientX - rect.left - size / 2;
      const y = e.clientY - rect.top - size / 2;

      ripple.style.cssText = `
        position: absolute;
        border-radius: 50%;
        background: rgba(255,255,255,0.6);
        transform: scale(0);
        animation: ripple 0.6s linear;
        left: ${x}px;
        top: ${y}px;
        width: ${size}px;
        height: ${size}px;
      `;

      button.style.position = "relative";
      button.style.overflow = "hidden";
      button.appendChild(ripple);

      setTimeout(() => ripple.remove(), 600);
    });
  });

  // Smooth scrolling for anchor links
  const anchorLinks = document.querySelectorAll('a[href^="#"]');
  anchorLinks.forEach(function (link) {
    link.addEventListener("click", function (e) {
      e.preventDefault();
      const target = document.querySelector(link.getAttribute("href"));
      if (target) {
        target.scrollIntoView({ behavior: "smooth" });
      }
    });
  });

  // Dynamic content loading indicators
  const forms = document.querySelectorAll("form");
  forms.forEach(function (form) {
    form.addEventListener("submit", function () {
      const submitBtn = form.querySelector(
        'input[type="submit"], button[type="submit"]'
      );
      if (submitBtn) {
        submitBtn.innerHTML =
          '<i class="fas fa-spinner fa-spin"></i> Processando...';
        submitBtn.disabled = true;
      }
    });
  });

  // Enhanced delete buttons with better UX
  initializeDeleteButtons();
}

// Enhanced delete button functionality
function initializeDeleteButtons() {
  const deleteButtons = document.querySelectorAll(
    '[data-turbo-method="delete"]'
  );

  deleteButtons.forEach(function (button) {
    button.addEventListener("click", function (e) {
      e.preventDefault();

      const confirmMessage = button.dataset.turboConfirm;
      const url = button.href || button.closest("form")?.action;

      // Custom confirmation dialog
      showDeleteConfirmation(confirmMessage, function () {
        // Show loading state
        button.style.opacity = "0.6";
        button.innerHTML =
          '<i class="fas fa-spinner fa-spin"></i> Excluindo...';

        // Submit the delete request
        const form = document.createElement("form");
        form.method = "POST";
        form.action = url;
        form.style.display = "none";

        const methodInput = document.createElement("input");
        methodInput.name = "_method";
        methodInput.value = "DELETE";
        methodInput.type = "hidden";

        const csrfInput = document.createElement("input");
        csrfInput.name = "authenticity_token";
        csrfInput.value = document.querySelector(
          'meta[name="csrf-token"]'
        ).content;
        csrfInput.type = "hidden";

        form.appendChild(methodInput);
        form.appendChild(csrfInput);
        document.body.appendChild(form);
        form.submit();
      });
    });
  });
}

// Custom delete confirmation dialog
function showDeleteConfirmation(message, onConfirm) {
  const modal = document.createElement("div");
  modal.className = "modal fade show";
  modal.style.cssText = "display: block; background: rgba(0,0,0,0.5);";

  modal.innerHTML = `
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-header border-0 pb-0">
          <h5 class="modal-title text-danger">
            <i class="fas fa-exclamation-triangle me-2"></i>Confirmar Exclusão
          </h5>
        </div>
        <div class="modal-body">
          <p class="mb-0">${message}</p>
        </div>
        <div class="modal-footer border-0 pt-0">
          <button type="button" class="btn btn-secondary btn-sm" data-action="cancel">
            <i class="fas fa-times me-1"></i>Cancelar
          </button>
          <button type="button" class="btn btn-danger btn-sm" data-action="confirm">
            <i class="fas fa-trash me-1"></i>Excluir
          </button>
        </div>
      </div>
    </div>
  `;

  document.body.appendChild(modal);

  // Add event listeners
  modal
    .querySelector('[data-action="cancel"]')
    .addEventListener("click", () => {
      modal.remove();
    });

  modal
    .querySelector('[data-action="confirm"]')
    .addEventListener("click", () => {
      modal.remove();
      onConfirm();
    });

  // Close on backdrop click
  modal.addEventListener("click", (e) => {
    if (e.target === modal) {
      modal.remove();
    }
  });

  // Close on escape key
  const escapeHandler = (e) => {
    if (e.key === "Escape") {
      modal.remove();
      document.removeEventListener("keydown", escapeHandler);
    }
  };
  document.addEventListener("keydown", escapeHandler);
}

// Auto-dismiss alerts after 5 seconds
function autoDismissAlerts() {
  const alerts = document.querySelectorAll(".alert-dismissible");

  alerts.forEach(function (alert) {
    // Add progress bar
    const progressBar = document.createElement("div");
    progressBar.style.cssText = `
      position: absolute;
      bottom: 0;
      left: 0;
      height: 3px;
      background: rgba(255,255,255,0.3);
      width: 100%;
      animation: progressBar 5s linear;
    `;
    alert.style.position = "relative";
    alert.appendChild(progressBar);

    setTimeout(function () {
      alert.style.animation = "fadeOut 0.5s ease-out";
      setTimeout(() => alert.remove(), 500);
    }, 5000);
  });
}

// Loading states for better UX
function initializeLoadingStates() {
  // Add loading state to navigation links
  const navLinks = document.querySelectorAll(".navbar-nav .nav-link");
  navLinks.forEach(function (link) {
    link.addEventListener("click", function () {
      // Add loading spinner
      const originalText = link.innerHTML;
      link.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';

      // Restore original text if page doesn't change (for some reason)
      setTimeout(() => {
        if (link.innerHTML.includes("fa-spinner")) {
          link.innerHTML = originalText;
        }
      }, 3000);
    });
  });
}

// Utility functions
function showNotification(message, type = "info") {
  const notification = document.createElement("div");
  notification.className = `alert alert-${type} alert-dismissible fade show position-fixed`;
  notification.style.cssText = `
    top: 20px;
    right: 20px;
    z-index: 9999;
    min-width: 300px;
    animation: slideIn 0.3s ease-out;
  `;

  notification.innerHTML = `
    ${message}
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
  `;

  document.body.appendChild(notification);

  // Auto remove after 5 seconds
  setTimeout(() => {
    notification.style.animation = "slideOut 0.3s ease-in";
    setTimeout(() => notification.remove(), 300);
  }, 5000);
}

// Add CSS animations
const style = document.createElement("style");
style.textContent = `
  @keyframes ripple {
    to { transform: scale(4); opacity: 0; }
  }
  
  @keyframes progressBar {
    from { width: 100%; }
    to { width: 0%; }
  }
  
  @keyframes fadeOut {
    from { opacity: 1; transform: translateY(0); }
    to { opacity: 0; transform: translateY(-20px); }
  }
  
  @keyframes slideIn {
    from { transform: translateX(100%); }
    to { transform: translateX(0); }
  }
  
  @keyframes slideOut {
    from { transform: translateX(0); }
    to { transform: translateX(100%); }
  }
  
  .loading {
    position: relative;
  }
  
  .loading::after {
    content: '';
    position: absolute;
    right: 10px;
    top: 50%;
    transform: translateY(-50%);
    width: 16px;
    height: 16px;
    border: 2px solid #f3f3f3;
    border-top: 2px solid #667eea;
    border-radius: 50%;
    animation: spin 1s linear infinite;
  }
  
  @keyframes spin {
    0% { transform: translateY(-50%) rotate(0deg); }
    100% { transform: translateY(-50%) rotate(360deg); }
  }
`;
document.head.appendChild(style);

// Export utility functions for use in other scripts
window.LibraryApp = {
  showNotification: showNotification,
};
