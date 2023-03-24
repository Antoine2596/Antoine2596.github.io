const tableSelector = document.getElementById('tableSelector');
const tableContainer = document.getElementById('tableContainer');

// Fonction pour charger le tableau sélectionné
function loadTable() {
  const tableUrl = tableSelector.value;
  tableContainer.innerHTML = `<iframe src="${tableUrl}" width="100%" height="500"></iframe>`;
}

// Charger le tableau initial
loadTable();

// Écouter les changements dans la liste déroulante
tableSelector.addEventListener('change', loadTable);
