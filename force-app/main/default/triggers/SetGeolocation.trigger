// Trigger runs getLocation() on Accounts with no Geolocation
trigger SetGeolocation on Account (after insert, before update) {
    for (Account a : trigger.new)
        if (a.Location__Latitude__s == null)
            LocationCallouts.getLocation(a.id);
}