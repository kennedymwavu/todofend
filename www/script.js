$(document).ready(function () {
  // show today's date:
  let days_of_week = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];
  let months_of_year = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  let today = new Date();
  let formatted_date =
    days_of_week[today.getDay()] +
    ", " +
    today.getDate() +
    get_day_suffix(today.getDate()) +
    " " +
    months_of_year[today.getMonth()] +
    " " +
    today.getFullYear();
  $("#today").text(formatted_date);
});

function get_day_suffix(day) {
  if (day >= 11 && day <= 13) {
    return "th";
  }
  switch (day % 10) {
    case 1: return "st";
    case 2: return "nd";
    case 3: return "rd";
    default: return "th";
  }
}
