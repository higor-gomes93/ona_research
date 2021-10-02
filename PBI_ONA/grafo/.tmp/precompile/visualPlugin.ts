import { Visual } from "../../src/visual";
import powerbiVisualsApi from "powerbi-visuals-api";
import IVisualPlugin = powerbiVisualsApi.visuals.plugins.IVisualPlugin;
import VisualConstructorOptions = powerbiVisualsApi.extensibility.visual.VisualConstructorOptions;
var powerbiKey: any = "powerbi";
var powerbi: any = window[powerbiKey];

var grafo095BD69588484FD7B48625E2AD350E5A: IVisualPlugin = {
    name: 'grafo095BD69588484FD7B48625E2AD350E5A',
    displayName: 'Grafo',
    class: 'Visual',
    apiVersion: '2.6.0',
    create: (options: VisualConstructorOptions) => {
        if (Visual) {
            return new Visual(options);
        }

        throw 'Visual instance not found';
    },
    custom: true
};

if (typeof powerbi !== "undefined") {
    powerbi.visuals = powerbi.visuals || {};
    powerbi.visuals.plugins = powerbi.visuals.plugins || {};
    powerbi.visuals.plugins["grafo095BD69588484FD7B48625E2AD350E5A"] = grafo095BD69588484FD7B48625E2AD350E5A;
}

export default grafo095BD69588484FD7B48625E2AD350E5A;