export const isDevelopment = process.env.NODE_ENV === 'development';
export const isProduction = process.env.NODE_ENV === 'production';
export const defaultMapCenter = { lat: 48.993174, lng: 2.271811 };

export const LayerNames = {
    snowOn: 'isprs-potsdam-dsm',
    snowOff: 'isprs-potsdam-dsm',
    addTin(ln) { return ln; },
    addIdw(ln) { return ln; },
};

export const polygonDefaults = {
    fillColor: '#0000FF',
    color: '#0000FF',
};
