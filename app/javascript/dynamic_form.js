document.addEventListener('turbo:load', () => {
    const inputTypeSelect = document.getElementById('input_text_select');
    // Add textCache to save input text value after reload
    const textCache = document.getElementById('text_cache').value;
  
    const validateFileExtension = () => {
      const fileInput = document.getElementById('file_input');
      
      if (fileInput && fileInput.files.length > 0) {
        const fileName = fileInput.files[0].name;
        const fileExt = fileName.split('.').pop().toLowerCase();
        if ( fileExt !== 'bin') {
          alert('Only .bin files are allowed for this cipher.');
          fileInput.value = ''; // Reset the file input
        }
      }
    };
    
    const updateDynamicField = (selection, dynamic_element) => {
      if (dynamic_element.id === 'dynamic_input_text_container'){
        if (selection === 'file') {
          document.getElementById('input_type').value = 'file';
          dynamic_element.innerHTML = `
            <div class="label-container">
              <label for="file_input">Input File:</label>
            </div>
            <div class="input-container">
              <input type="file" name="file" id="file_input" class="file-input">
            </div>
          `;
        } else {
          document.getElementById('input_type').value = 'text';
          dynamic_element.innerHTML = `
            <div class="label-container">
              <label for="text_input">Input Text:</label>
            </div>
            <div class="input-container">
              <textarea name="text" id="text_input" class="plain-text">${textCache}</textarea>
            </div>
          `;
        } 
      }
    };

    const fileInput = document.getElementById('file_input');
    if (fileInput) {
      fileInput.addEventListener('change', validateFileExtension);
    }
    
    // Get dynamic containers
    const dynamicInputText = document.getElementById('dynamic_input_text_container');

  
    // Initialize dynamic fields based on current selection
    updateDynamicField(inputTypeSelect.value, dynamicInputText);
  
    // Update dynamic field on selection change
    inputTypeSelect.addEventListener('change', () => {
      updateDynamicField(inputTypeSelect.value, dynamicInputText);
    
      const newFileInput = document.getElementById('file_input');
      if (newFileInput){
        newFileInput.addEventListener('change', validateFileExtension)
      }
    });
  
    fileInput.addEventListener('change', validateFileExtension);
  
  });