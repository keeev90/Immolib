const element = document.getElementById('pickadate');
const hiddenInput = document.getElementById('start_date');

const roundDate = date => {

  minutes = Math.ceil(date.getMinutes() / 15) * 15;

  date.setMinutes(minutes, 0, 0);

  return date;
}

const initialState = {
  selected: roundDate(new Date()),
  firstDayOfWeek: 1,
  template: 'DD MMMM YYYY - HH:mm',
  templateHookWords: {
    MMM: ['Jan', 'Fev', 'Mar', 'Avr', 'Mai', 'Juin', 'Juil', 'Aou', 'Sep', 'Oct', 'Nov', 'Dec'],
    MMMM: ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'],
    DDD: ['Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam'],
    DDDD: ['Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi']
  }
};

const picker = pickadate.create(initialState);

pickadate.render(element, picker);

const parseDate = date => {
  let oldDate = date.split(' ');
  const months = [
    'Janvier',
    'Février',
    'Mars',
    'Avril',
    'Mai',
    'Juin',
    'Juillet',
    'Août',
    'Septembre',
    'Octobre',
    'Novembre',
    'Décembre'
  ]

  oldDate[1] = months.findIndex(e => e === oldDate[1]) + 1;

  return `${oldDate[2]}-${oldDate[1]}-${oldDate[0]}T${oldDate[4]}:00+01:00`;
}

const onChange = e => {
  e.preventDefault();
  element.value = picker.getValue();
  hiddenInput.value = parseDate(picker.getValue());
}

element.addEventListener('pickadate:change', onChange);