document.addEventListener('turbo:load', () => {
    const inputTypeSelect = document.getElementById('input_text_select');
    const modeSelect = document.getElementById('mode_select');
    // Add textCache to save input text value after reload
    const textCache = document.getElementById('text_cache').value;
    
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
      } else if (dynamic_element.id === 'dynamic_mode_container'){
          const existingRSizeContainer = document.getElementById('r_size_container');
          if (existingRSizeContainer){
            existingRSizeContainer.parentNode.removeChild(existingRSizeContainer);
          }
          if (selection === 'cfb' || selection === 'ofb'){
            const rSizeContainer = document.createElement('div');
            rSizeContainer.setAttribute('class', 'field-container')
            rSizeContainer.setAttribute('id', 'r_size_container');
            rSizeContainer.innerHTML = `
              <div class="label-container">
                <label for="r_size">R Size (bytes):</label>
              </div>
              <div class="input-container">
                <select id="r" name="r">
                  <option value="1">1</option>
                  <option value="2">2</option>
                  <option value="4">4</option>
                  <option value="8">8</option>
                  <option value="16">16</option>
                </select>
              </div>
            `;
            dynamic_element.parentNode.insertBefore(rSizeContainer, dynamic_element.nextSibling);

          } 
      }
    };
    
    // Get dynamic containers
    const dynamicInputText = document.getElementById('dynamic_input_text_container');
    const dynamicMode = document.getElementById('dynamic_mode_container')
  
    // Initialize dynamic fields based on current selection
    updateDynamicField(inputTypeSelect.value, dynamicInputText);
    updateDynamicField(modeSelect.value, dynamicMode);
    // Update dynamic field on selection change
    inputTypeSelect.addEventListener('change', () => {
      updateDynamicField(inputTypeSelect.value, dynamicInputText);
    });
    
    modeSelect.addEventListener('change', () => {
      updateDynamicField(modeSelect.value, dynamicMode)
    })

  });