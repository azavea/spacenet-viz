export const isDevelopment = process.env.NODE_ENV === 'development';
export const isProduction = process.env.NODE_ENV === 'production';
export const defaultMapCenter = { lat: 49.045040, lng: 2.190852 };

export const LayerNames = {
    snowOn : "isprs-potsdam-dsm",
    snowOff: "isprs-potsdam-dsm",
    addTin: function(ln) { return ln; },
    addIdw: function(ln) { return ln; }
};

export const polygonDefaults = {
    fillColor: '#0000FF',
    color: '#0000FF',
};
