json.reservations @reservations do |reservation|
  json.reservationId reservation.id
  json.from reservation.from_date
  json.to reservation.to_date
  json.guestsCount reservation.no_of_guests
  json.user do 
    json.id reservation.user.id
    json.firstname reservation.user.firstname
    json.lastname reservation.user.lastname
  end
end
