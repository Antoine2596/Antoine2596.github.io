const monElement = document.getElementById('monElement');

window.addEventListener('scroll', () => {
  const rect = monElement.getBoundingClientRect();
  const ecranHauteur = window.innerHeight;
  const centreVertical = (ecranHauteur / 2) - (rect.height / 2);

  if (rect.top <= centreVertical && rect.bottom >= centreVertical) {
    monElement.classList.add('maClasse');
  } else {
    monElement.classList.remove('maClasse');
  }
});