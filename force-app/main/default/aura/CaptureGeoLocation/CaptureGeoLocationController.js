({
	onInit : function(component, event, helper) {
        if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
            var lat = position.coords.latitude;
            var lon = position.coords.longitude;
            console.log(lat);
            component.set( "v.latValue", lat);
            component.set( "v.longValue", lon);
            component.set( "v.errorMsg", 'Location Capture Successfully');
                          
            /*var action = component.get("c.getCityName");
            action.setParams({
                "latitude": lat,
                "longitude": lon
            });
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var location = response.getReturnValue();
                }
            });
            $A.enqueueAction(action);*/
            
        },
        function(error) { 
        	var err = error.message;
            component.set( "v.errorMsg", err);
        }
                                                );
    } else {
        console.log('Your browser does not support GeoLocation');
        component.set( "v.errorMsg", 'Your browser does not support GeoLocation');
    }
		
	}
})