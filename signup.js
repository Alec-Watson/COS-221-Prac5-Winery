// Alec's code
// Get references to the form and its input fields
const form = document.getElementById('signupForm');
const emailInput = document.getElementById('email');
const passwordInput = document.getElementById('password');

const emailRegex = /^(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/;

const passwordRegex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*[\W_]).{8,}$/;

function validateEmailPasswordForm(event) {
  // Prevent the form from submitting
  event.preventDefault();

  // Get the input values
  const email = emailInput.value.trim();
  const password = passwordInput.value.trim();

  // Validate the input values
  let isValid = true;
  if (!emailRegex.test(email)) {
    alert('Please enter a valid email address.');
    isValid = false;
  }
  if (!passwordRegex.test(password)) {
    alert('Please enter a valid password. Passwords must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one digit, and one special character.');
    isValid = false;
  }
  if (isValid) {
    form.submit();
  }
}

// Get references to the country-region-name form and its input fields
const countryInput = document.getElementById('country');
const regionInput = document.getElementById('region');
const nameInput = document.getElementById('name');

if (checkbox.checked) {
  // Get the input values
  const country = countryInput.value.trim();
  const region = regionInput.value.trim();
  const name = nameInput.value.trim();

  // Validate the input values
  let isValid = true;
  if (!country) {
    alert('Please enter a country.');
    isValid = false;
  }
  if (!region) {
    alert('Please enter a region.');
    isValid = false;
  }
  if (!name) {
    alert('Please enter a name.');
    isValid = false;
  }
  if (isValid) {
    // Perform the desired action for the country-region-name form
    
  }
}

// Add event listeners for each form
form.addEventListener('submit', validateEmailPasswordForm);

// Show/hide form based on checkbox state
const checkbox = document.getElementById('showForm');
const formContainer = document.getElementById('wineryContainer');

checkbox.addEventListener('change', function() {
  if (checkbox.checked) {
    formContainer.classList.remove('hidden');
  } else {
    formContainer.classList.add('hidden');
  }
});