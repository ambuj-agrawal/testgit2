({
    afterScriptsLoaded : function(component, event, helper) 
    {
        var data=[0, 1500, 2500, 3000] ;
        var value=[1200] ;
        new Chart(document.getElementById("chart"), {
            type: 'gauge',
            data: {
                //labels: ['Success', 'Warning', 'Warning', 'Error'],
                datasets: [{
                    data: data,
                    value: value,
                    backgroundColor: ['#FFFFFF', '#F37A21', 'orange', 'red'],
                    borderWidth: 2
                }]
            },
            options: {
                responsive: true,
                title: {
                    display: true,
                    text: 'Gauge chart with datalabels plugin'
                },
                layout: {
                    padding: {
                        bottom: 30
                    }
                },
                needle: {
                    // Needle circle radius as the percentage of the chart area width
                    radiusPercentage: 1,
                    // Needle width as the percentage of the chart area width
                    widthPercentage: 2,
                    // Needle length as the percentage of the interval between inner radius (0%) and outer radius (100%) of the arc
                    lengthPercentage: 1,
                    // The color of the needle
                    color: 'rgba(0, 0, 0, 1)'
                },
                valueLabel: {
                    formatter: Math.round
                },
                plugins: {
                    datalabels: {
                        display: true,
                        formatter: function (value, context) {
                            return '< ' + Math.round(value);
                        },
                        color: function (context) {
                            return context.dataset.backgroundColor;
                        },
                        //color: 'rgba(255, 255, 255, 1.0)',
                        backgroundColor: 'rgba(0, 0, 0, 1.0)',
                        borderWidth: 0,
                        borderRadius: 5,
                        font: {
                            weight: 'bold'
                        }
                    }
                }
            }
        });
    },
})