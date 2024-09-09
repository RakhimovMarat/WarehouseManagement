document.addEventListener("DOMContentLoaded", () => {
  const warehouseSelect = document.getElementById("warehouse-select");
  const addressSelect = document.getElementById("address-select");

  warehouseSelect.addEventListener("change", () => {
    const warehouseId = warehouseSelect.value;

    if (!warehouseId) {
      addressSelect.innerHTML = '<option valuse="">Сначала выберите склад</option>';
      return;
    }

    fetch(`/addresses?warehouse_id=${warehouseId}`)
      .then(response => response.json())
      .then(data => {
        addressSelect.innerHTML = '';

        const defaultOption = document.createElement('option');
        defaultOption.value = '';
        defaultOption.textContent = 'Выберите адрес';
        addressSelect.appendChild(defaultOption);

        data.forEach(adddress => {
          const option = document.createElement('option');
          option.value = adddress.id;
          option.textContent = adddress.name;
          addressSelect.appendChild(option);
        });
      })
      .catch(error => console.error('Ошибка', error));
  });
});