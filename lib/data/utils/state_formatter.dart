String stateToString(String state) {
  switch (state) {
    case "CREATED":
      return "Creado";
    case "RECEIVED":
      return "Vehículo recibido";
    case "PAID":
      return "Reserva pagada";
    case "RETURNED":
      return "Vehículo devuelto";
    case "CONFIRMED":
      return "Finalizado";
    default:
      return "Creado";
  }
}

String stateToWord(String state) {
  switch (state) {
    case "CREATED":
      return "Creado";
    case "RECEIVED":
      return "Recibido";
    case "PAID":
      return "Pagado";
    case "RETURNED":
      return "Devuelto";
    case "CONFIRMED":
      return "Finalizado";
    default:
      return "Creado";
  }
}
