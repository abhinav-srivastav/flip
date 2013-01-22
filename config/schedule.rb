#runner job for shipping booked order  
every 1.hour do
  runner " Order.dispatch(Time.now-2.hours)"
end