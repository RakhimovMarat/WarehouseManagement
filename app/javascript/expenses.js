document.addEventListener("DOMContentLoaded", () => {
    const itemSelect = document.getElementById("item-select");
    const warehouseSelect = document.getElementById("warehouse-select");
    const addressSelect = document.getElementById("address-select");
  
    itemSelect.addEventListener("change", () => {
      const itemId = itemSelect.value;
  
      if (!itemId) {
        warehouseSelect.innerHTML = '<option value="">Сначала выберите товар</option>';
        addressSelect.innerHTML = '<option value="">Сначала выберите склад</option>';
        return;
      }
  
      fetch(`/warehouses?item_id=${itemId}`)
        .then(response => response.json())
        .then(data => {
          warehouseSelect.innerHTML = '';
  
          const defaultOption = document.createElement('option');
          defaultOption.value = '';
          defaultOption.textContent = 'Выберите склад';
          warehouseSelect.appendChild(defaultOption);
  
          data.forEach(warehouse => {
            const option = document.createElement('option');
            option.value = warehouse.id;
            option.textContent = warehouse.name;
            warehouseSelect.appendChild(option);
          });
        })
        .catch(error => console.error('Ошибка при загрузке складов', error));
    });
  
    warehouseSelect.addEventListener("change", () => {
      const warehouseId = warehouseSelect.value;
      const itemId = itemSelect.value; // Убедитесь, что itemId корректно передается
    
      console.log(`Selected warehouse_id: ${warehouseId}, item_id: ${itemId}`);
    
      if (!warehouseId) {
        addressSelect.innerHTML = '<option value="">Сначала выберите склад</option>';
        return;
      }
    
      fetch(`/addresses?warehouse_id=${warehouseId}&item_id=${itemId}`)
        .then(response => response.json())
        .then(data => {
          addressSelect.innerHTML = '';
          const defaultOption = document.createElement('option');
          defaultOption.value = '';
          defaultOption.textContent = 'Выберите адрес';
          addressSelect.appendChild(defaultOption);
          data.forEach(address => {
            const option = document.createElement('option');
            option.value = address.id;
            option.textContent = address.name;
            addressSelect.appendChild(option);
          });
        })
        .catch(error => console.error('Ошибка при загрузке адресов', error));
    });    
  });
  