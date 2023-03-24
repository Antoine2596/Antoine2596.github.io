const table = document.getElementById('myTable');
const rowCountInput = document.getElementById('rowCount');
rowCountInput.value = 623; // Définir la valeur par défaut à 10
const updateButton = document.getElementById('updateTable');

function updateTable() {
  // Récupérer le nombre de lignes choisi par l'utilisateur
  const rowCount = parseInt(rowCountInput.value);

  // Récupérer toutes les lignes du tableau (sauf l'en-tête)
  const rows = table.querySelectorAll('tbody tr');

  // Parcourir les lignes et définir la propriété "display" en fonction du nombre de lignes à afficher
  for (let i = 0; i < rows.length; i++) {
    if (i < rowCount) {
      rows[i].style.display = 'table-row';
    } else {
      rows[i].style.display = 'none';
    }
  }
}

// Mettre à jour le tableau lorsque l'utilisateur clique sur le bouton
updateButton.addEventListener('click', updateTable);

updateTable();
