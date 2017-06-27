import React, { Component, PropTypes } from 'react';

import { Slider, Button, Tabs, TabList, TabPanel, Tab } from "@blueprintjs/core";

import {
    setImageryType,
    setImageryOpacity,
    setDsmType,
    setDsmOpacity,
    setLabelsType,
    setLabelsOpacity,
    setModelPredictionType,
    setModelPredictionOpacity,
    setModelProbabilitiesType,
    setModelProbabilitiesOpacity,
    setModelProbabilitiesLabel,
    setAbType,
    setAbOpacity
} from './actions';

export default class SingleLayer extends Component {
    constructor() {
        super();

        // Imagery

        this.checkRgb = this.checkRgb.bind(this);
        this.checkIrrg = this.checkIrrg.bind(this);
        this.checkIrgb = this.checkIrgb.bind(this);
        this.checkGrayscale = this.checkGrayscale.bind(this);
        this.checkNdvi = this.checkNdvi.bind(this);
        this.checkVegetation = this.checkVegetation.bind(this);
        this.checkShadow = this.checkShadow.bind(this);
        this.checkCement = this.checkCement.bind(this);
        this.checkSedimentation = this.checkSedimentation.bind(this);
        this.checkMudFlats = this.checkMudFlats.bind(this);
        this.checkRedRoofs = this.checkRedRoofs.bind(this);
        this.checkWaterDepth = this.checkWaterDepth.bind(this);
        this.checkUrban = this.checkUrban.bind(this);
        this.checkBlackwater = this.checkBlackwater.bind(this);
        this.checkIR1 = this.checkIR1.bind(this);
        this.checkIR2 = this.checkIR2.bind(this);
        this.checkNoImagery = this.checkNoImagery.bind(this);
        this.handleImageryOpacityChange = this.handleImageryOpacityChange.bind(this);

        // DSM

        this.checkColorRamp = this.checkColorRamp.bind(this);
        this.checkHillshade = this.checkHillshade.bind(this);
        this.checkNoDsm = this.checkNoDsm.bind(this);
        this.handleDsmOpacityChange = this.handleDsmOpacityChange.bind(this);

        // DSM - GT

        this.checkGtColorRamp = this.checkGtColorRamp.bind(this);
        this.checkGtHillshade = this.checkGtHillshade.bind(this);
        this.checkGtNoDsm = this.checkGtNoDsm.bind(this);
        this.handleDsmGtOpacityChange = this.handleDsmGtOpacityChange.bind(this);

        // Labels

        this.checkLabels = this.checkLabels.bind(this);
        this.checkNoLabels = this.checkNoLabels.bind(this);
        this.handleLabelsOpacityChange = this.handleLabelsOpacityChange.bind(this);

        // Model Predictions

        this.checkModelPredictionAllHandler = this.checkModelPredictionAllHandler.bind(this);
        this.checkModelPredictionIncorrectHandler = this.checkModelPredictionIncorrectHandler.bind(this);
        this.checkNoModelPredictionHandler = this.checkNoModelPredictionHandler.bind(this);
        this.handleModelPredicitionOpacityChangeHandler = this.handleModelPredictionOpacityChangeHandler.bind(this);

        // Model Probabilities

        this.checkModelProbabilitiesHandler = this.checkModelProbabilitiesHandler.bind(this);
        this.checkNoModelProbabilitiesHandler = this.checkNoModelProbabilitiesHandler.bind(this);
        this.handleModelProbabilitiesLabelHandler = this.handleModelProbabilitiesLabelHandler.bind(this);
        this.handleModelProbabilitiesOpacityChangeHandler = this.handleModelProbabilitiesOpacityChangeHandler.bind(this);

        // AB

        this.checkAb = this.checkAb.bind(this);
        this.checkNoAb = this.checkNoAb.bind(this);
        this.handleAbOpacityChange = this.handleAbOpacityChange.bind(this);

        // ABDSM

        this.checkAbDsm = this.checkAbDsm.bind(this);
        this.checkNoAbDsm = this.checkNoAbDsm.bind(this);
        this.handleAbDsmOpacityChange = this.handleAbDsmOpacityChange.bind(this);
    }

    // Imagery

    checkRgb() {
        const { dispatch } = this.props;
        dispatch(setImageryType("RGB"));
    }

    checkIrrg() {
        const { dispatch } = this.props;
        dispatch(setImageryType("IRRG"));
    }

    checkIrgb() {
        const { dispatch } = this.props;
        dispatch(setImageryType("IRGB"));
    }

    checkGrayscale() {
        const { dispatch } = this.props;
        dispatch(setImageryType("GRAYSCALE"));
    }

    checkNdvi() {
        const { dispatch } = this.props;
        dispatch(setImageryType("NDVI"));
    }

    checkVegetation() {
        const { dispatch } = this.props;
        dispatch(setImageryType("VEGETATION"));
    }

    checkShadow() {
        const { dispatch } = this.props;
        dispatch(setImageryType("SHADOW"));
    }

    checkCement() {
        const { dispatch } = this.props;
        dispatch(setImageryType("CEMENT"));
    }

    checkSedimentation() {
        const { dispatch } = this.props;
        dispatch(setImageryType("SEDIMENTATION"));
    }

    checkMudFlats() {
        const { dispatch } = this.props;
        dispatch(setImageryType("MUDFLATS"));
    }

    checkRedRoofs() {
        const { dispatch } = this.props;
        dispatch(setImageryType("REDROOFS"));
    }

    checkWaterDepth() {
        const { dispatch } = this.props;
        dispatch(setImageryType("WATERDEPTH"));
    }

    checkUrban() {
        const { dispatch } = this.props;
        dispatch(setImageryType("URBAN"));
    }

    checkBlackwater() {
        const { dispatch } = this.props;
        dispatch(setImageryType("BLACKWATER"));
    }

    checkIR1() {
        const { dispatch } = this.props;
        dispatch(setImageryType("IR1"));
    }

    checkIR2() {
        const { dispatch } = this.props;
        dispatch(setImageryType("IR2"));
    }

    checkNoImagery() {
        const { dispatch } = this.props;
        dispatch(setImageryType("NONE"));
    }

    handleImageryOpacityChange(value) {
        const { dispatch } = this.props;
        dispatch(setImageryOpacity(value));
    }

    // DSM

    checkColorRamp() {
        const { dispatch } = this.props;
        dispatch(setDsmType("COLORRAMP"));
    }

    checkHillshade() {
        const { dispatch } = this.props;
        dispatch(setDsmType("HILLSHADE"));
    }

    checkNoDsm() {
        const { dispatch } = this.props;
        dispatch(setDsmType("NONE"));
    }

    handleDsmOpacityChange(value) {
        const { dispatch } = this.props;
        dispatch(setDsmOpacity(value));
    }

    // GT DSM

    checkGtColorRamp() {
        const { dispatch } = this.props;
        dispatch(setDsmType("COLORRAMP", "gt"));
    }

    checkGtHillshade() {
        const { dispatch } = this.props;
        dispatch(setDsmType("HILLSHADE", "gt"));
    }

    checkGtNoDsm() {
        const { dispatch } = this.props;
        dispatch(setDsmType("NONE", "gt"));
    }

    handleDsmGtOpacityChange(value) {
        const { dispatch } = this.props;
        dispatch(setDsmOpacity(value, "gt"));
    }

    // Labels

    checkLabels() {
        const { dispatch } = this.props;
        dispatch(setLabelsType("CHECKED"));
    }

    checkNoLabels() {
        const { dispatch } = this.props;
        dispatch(setLabelsType("NONE"));
    }

    handleLabelsOpacityChange(value) {
        const { dispatch } = this.props;
        dispatch(setLabelsOpacity(value));
    }

    // Model Predictions

    checkModelPredictionAllHandler(modelId) {
        const { dispatch } = this.props;
        return function() {
            dispatch(setModelPredictionType(modelId, "ALL"));
        };
    }

    checkModelPredictionIncorrectHandler(modelId) {
        const { dispatch } = this.props;
        return function() {
            dispatch(setModelPredictionType(modelId, "INCORRECT"));
        };
    }

    checkNoModelPredictionHandler(modelId) {
        const { dispatch } = this.props;
        return function() {
            dispatch(setModelPredictionType(modelId, "NONE"));
        };
    }

    handleModelPredictionOpacityChangeHandler(modelId) {
        const { dispatch } = this.props;
        return function(value) {
            dispatch(setModelPredictionOpacity(modelId, value));
        }
    }

    // Model Probabilities

    checkModelProbabilitiesHandler(modelId) {
        const { dispatch } = this.props;
        return function() {
            dispatch(setModelProbabilitiesType(modelId, "CHECKED"));
        };
    }

    checkNoModelProbabilitiesHandler(modelId) {
        const { dispatch } = this.props;
        return function() {
            dispatch(setModelProbabilitiesType(modelId, "NONE"));
        };
    }

    handleModelProbabilitiesLabelHandler(modelId, labelId) {
        const { dispatch } = this.props;
        return function() {
            dispatch(setModelProbabilitiesLabel(modelId, labelId));
        };
    }

    handleModelProbabilitiesOpacityChangeHandler(modelId) {
        const { dispatch } = this.props;
        return function(value) {
            dispatch(setModelProbabilitiesOpacity(modelId, value));
        }
    }

    // AB

    checkAb() {
        const { dispatch } = this.props;
        dispatch(setAbType("CHECKED"));
    }

    checkNoAb() {
        const { dispatch } = this.props;
        dispatch(setAbType("NONE"));
    }

    handleAbOpacityChange(value) {
        const { dispatch } = this.props;
        dispatch(setAbOpacity(value));
    }

    // ABDSM

    checkAbDsm() {
        const { dispatch } = this.props;
        dispatch(setAbType("CHECKED", "dsm"));
    }

    checkNoAbDsm() {
        const { dispatch } = this.props;
        dispatch(setAbType("NONE", "dsm"));
    }

    handleAbDsmOpacityChange(value) {
        const { dispatch } = this.props;
        dispatch(setAbOpacity(value, "dsm"));
    }

    isActive(b) {
        return b ? "pt-active" : "";
    }

    isActiveLabel(b, v) {
        return b == v ? "pt-active" : "";
    }

    render() {
        const {
            imagery,
            dsm,
            dsmGt,
            labels,
            models,
            ab,
            abDsm } = this.props;

        var modelSections = [];
        for (var property in models) {
            if (models.hasOwnProperty(property)) {
                var modelId = property;
                var model = models[modelId];
                var predictions = model.predictions;
                var probabilities = model.probabilities;
                // Model Predictions

                var checkModelPredictionAll = this.checkModelPredictionAllHandler(modelId);
                var checkModelPredictionIncorrect = this.checkModelPredictionIncorrectHandler(modelId);
                var checkNoModelPrediction = this.checkNoModelPredictionHandler(modelId);
                var handleModelPredictionOpacityChange = this.handleModelPredicitionOpacityChangeHandler(modelId);

                // Model Probabilities

                var checkModelProbabilities = this.checkModelProbabilitiesHandler(modelId);
                var checkNoModelProbabilities = this.checkNoModelProbabilitiesHandler(modelId);
                var handleModelProbabilitiesOpacityChange = this.handleModelProbabilitiesOpacityChangeHandler(modelId);

                var handleImperviousSurface = this.handleModelProbabilitiesLabelHandler(modelId, 0);
                var handleBuilding = this.handleModelProbabilitiesLabelHandler(modelId, 1);
                var handleLowVeg = this.handleModelProbabilitiesLabelHandler(modelId, 2);
                var handleTrees = this.handleModelProbabilitiesLabelHandler(modelId, 3);
                var handleCars = this.handleModelProbabilitiesLabelHandler(modelId, 4);
                var handleClutter = this.handleModelProbabilitiesLabelHandler(modelId, 5);

                var probabilitiesLabelButtons = null;
                if(probabilities.checked) {
                    probabilitiesLabelButtons =
                    [<div className="pt-button-group pt-vertical pt-fill">
                        <Button
                            active={predictions.labelId == 0}
                            onClick={handleImperviousSurface}
                            text="Impervious Surfaces"
                            className={this.isActiveLabel(probabilities.labelId, 0)}
                        />
                        <Button
                            active={probabilities.labelId == 1}
                            onClick={handleBuilding}
                            text="Building"
                            className={this.isActiveLabel(probabilities.labelId, 1)}
                        />
                        <Button
                            active={probabilities.labelId == 2}
                            onClick={handleLowVeg}
                            text="Low Vegatation"
                            className={this.isActiveLabel(probabilities.labelId, 2)}
                        />
                        <Button
                            active={probabilities.labelId == 3}
                            onClick={handleTrees}
                            text="Trees"
                            className={this.isActiveLabel(probabilities.labelId, 3)}
                        />
                        <Button
                            active={probabilities.labelId == 4}
                            onClick={handleCars}
                            text="Cars"
                            className={this.isActiveLabel(probabilities.labelId, 4)}
                        />
                        <Button
                            active={probabilities.labelId == 5}
                            onClick={handleClutter}
                            text="Clutter"
                            className={this.isActiveLabel(probabilities.labelId, 5)}
                        />
                    </div>]
                }


                modelSections.push(
                    <div className="option-section">
                        <label htmlFor="" className="primary">Model Predictions: {model.name}</label>
                        <div className="pt-button-group pt-fill">
                            <Button
                                active={predictions.allChecked}
                                onClick={checkModelPredictionAll}
                                text="ALL"
                                className={this.isActive(predictions.allChecked)}
                            />
                            <Button
                                active={predictions.incorrectChecked}
                                onClick={checkModelPredictionIncorrect}
                                text="WRONG"
                                className={this.isActive(predictions.incorrectChecked)}
                            />
                            <Button
                                active={!(predictions.allChecked || predictions.incorrectChecked)}
                                onClick={checkNoModelPrediction}
                                text="OFF"
                                className={this.isActive(!(predictions.allChecked || predictions.incorrectChecked))}
                            />
                        </div>
                        <div className="slider-section">
                            <label htmlFor="" className="secondary">Opacity</label>
                            <Slider
                                min={0}
                                max={1}
                                stepSize={0.02}
                                renderLabel={false}
                                value={predictions.opacity}
                                onChange={handleModelPredictionOpacityChange}
                            />
                        </div>
                    </div>
                )
                modelSections.push(
                    <div className="option-section">
                        <label htmlFor="" className="primary">Model Probabilities: {model.name}</label>
                        <div className="pt-button-group pt-fill">
                            <Button
                                active={probabilities.checked}
                                onClick={checkModelProbabilities}
                                text="ON"
                                className={this.isActive(probabilities.checked)}
                            />
                            <Button
                                active={!probabilities.checked}
                                onClick={checkNoModelProbabilities}
                                text="OFF"
                                className={this.isActive(!probabilities.checked)}
                            />
                        </div>
                        <div className="slider-section">
                            <label htmlFor="" className="secondary">Opacity</label>
                            <Slider
                                min={0}
                                max={1}
                                stepSize={0.02}
                                renderLabel={false}
                                value={probabilities.opacity}
                                onChange={handleModelProbabilitiesOpacityChange}
                            />
                        </div>
                        {probabilitiesLabelButtons}
                    </div>
                )
            }
        }

        return (
            <div className="content tab-content content-singlelayer active">
                <div className="option-section">
                    <label htmlFor="" className="primary">Imagery</label>
                    <div className="pt-button-group pt-fill">
                        <Button
                            active={imagery.rgbChecked}
                            onClick={this.checkRgb}
                            text="RGB"
                            className={this.isActive(imagery.rgbChecked)}
                            title='5,3,2 (Red,Green,Blue)
The "natural color" band combination. Because the visible bands are used in this combination, ground features appear
in colors similar to their appearance to the human visual system, healthy vegetation is green, recently cleared fields are
very light, unhealthy vegetation is brown and yellow, roads are gray, and shorelines are white.'
                        />
                        <Button
                            active={imagery.irrgChecked}
                            onClick={this.checkIrrg}
                            text="IRRG"
                            className={this.isActive(imagery.irrgChecked)}
                            title='7,5,3 (NIR1,Red,Green)
The standard "false color" composite. Vegetation appears in shades of red, urban areas are cyan blue, and soils vary
from dark to light browns. Ice, snow and clouds are white or light cyan. Coniferous trees will appear darker red than
hardwoods. This is a very popular band combination and is useful for vegetation studies, monitoring drainage and soil
patterns and various stages of crop growth. Densely populated urban areas are shown in light blue. This band
combination gives results similar to traditional color infrared aerial photography.'
                        />
                        <Button
                            active={imagery.irgbChecked}
                            onClick={this.checkIrgb}
                            text="IRGB"
                            className={this.isActive(imagery.irgbChecked)}
                            title='7,3,2 (NIR1,Green,Blue)
Modified “false color” composite band combination. Generally, this band combination differentiates conifer-deciduousgrassy
vegetation with a broader hue change than the standard false color composite band combination. Conifers
appear dark-red, deciduous tend to be represented in brighter-reds while grassy areas tend to show up with orange-red
hues.'
                        />
                    </div>
                    <div className="pt-button-group pt-fill">
                        <Button
                            active={imagery.ndviChecked}
                            onClick={this.checkNdvi}
                            text="NDVI"
                            className={this.isActive(imagery.ndviChecked)}
                        />
                        <Button
                            active={imagery.grayscaleChecked}
                            onClick={this.checkGrayscale}
                            text="GRAYSCALE"
                            className={this.isActive(imagery.grayscaleChecked)}
                        />
                        <Button
                            active={!(imagery.rgbChecked || imagery.irrgChecked || imagery.irgbChecked || imagery.ndviChecked || imagery.grayscaleChecked)}
                            onClick={this.checkNoImagery}
                            text="OFF"
                            className={this.isActive(!(imagery.rgbChecked || imagery.irrgChecked || imagery.irgbChecked || imagery.ndviChecked || imagery.grayscaleChecked))}
                        />
                    </div>
                    <br></br>
                    <label htmlFor="" className="primary"><a href="https://blogs.esri.com/esri/arcgis/2013/07/31/band-combinations-for-worldview-2/">Esri Blog</a> - Combos for Worldview 2 (see <a href="http://content.satimagingcorp.com/media/pdf/WorldView-2_8-Band_Applications_Whitepaper.pdf">Digital Globe Whitepaper</a>)</label>
                    <div className="pt-button-group pt-fill">
                        <Button
                            active={imagery.vegetationChecked}
                            onClick={this.checkVegetation}
                            text="VEGETATION"
                            className={this.isActive(imagery.vegetationChecked)}
                            title="Vegetation Composite (left). NIR2 | Yellow | Coastal. Higher levels of vegetation correlate with deeper reds. I thought this did a pretty good job from low to high levels of vegetation. A traditional False Color Composite (NIR1 | Red | Green) is shown on the right. Dubrovnik, Croatia."
                        />
                        <Button
                            active={imagery.shadowChecked}
                            onClick={this.checkShadow}
                            text="SHADOW"
                            className={this.isActive(imagery.shadowChecked)}
                            title="Shadow Composite. NIR2 | Red Edge | Yellow. There are a few options here, incorporating both a NIR band and the red-edge band, plus any other visible band. This combination seemed to make the shadows pop out more. Dubrovnik, Croatia."
                        />
                    </div>
                    <div className="pt-button-group pt-fill">
                        <Button
                            active={imagery.cementChecked}
                            onClick={this.checkCement}
                            text="CEMENT"
                            className={this.isActive(imagery.cementChecked)}
                            title="Cement Composite. NIR2 | Yellow | Blue. There are a few options here. I chose this one because there’s a greater distinction with what’s on the cement (i.e. painted stripes and cars) than what I saw in the other potential composites. Dubrovnik, Croatia."
                        />
                        <Button
                            active={imagery.sedimentationChecked}
                            onClick={this.checkSedimentation}
                            text="SEDIMENTATION"
                            className={this.isActive(imagery.sedimentationChecked)}
                            title="Sedimentation Composite. Red | Yellow | Coastal. New York City."
                        />
                    </div>
                    <div className="pt-button-group pt-fill">
                        <Button
                            active={imagery.mudFlatsChecked}
                            onClick={this.checkMudFlats}
                            text="MUDFLATS"
                            className={this.isActive(imagery.mudFlatsChecked)}
                            title="Mud Flat Composite. Red Edge | Yellow | Coastal. You heard it here first. This is the Al Khor Wildlife Reserve in Dubai. The green areas are mudflats used by flamingos for breeding and feeding. You can see the channels that cut through the flats well."
                        />
                        <Button
                            active={imagery.redRoofsChecked}
                            onClick={this.checkRedRoofs}
                            text="REDROOFS"
                            className={this.isActive(imagery.redRoofsChecked)}
                            title="Red Roof Composite. Red | Yellow | Green. Dubrovnik, Croatia."
                        />
                    </div>
                    <div className="pt-button-group pt-fill">
                            <Button
                                active={imagery.waterDepthChecked}
                                onClick={this.checkWaterDepth}
                                text="WATERDEPTH"
                                className={this.isActive(imagery.waterDepthChecked)}
                                title="Water Depth Composite. Green | Blue | Coastal. Dubrovnik, Croatia."
                            />
                            <Button
                                active={!(imagery.vegetationChecked || imagery.cementChecked || imagery.shadowChecked || imagery.cementChecked || imagery.sedimentationChecked || imagery.mudFlatsChecked || imagery.redRoofsChecked || imagery.waterDepthChecked)}
                                onClick={this.checkNoImagery}
                                text="OFF"
                                className={this.isActive(!(imagery.vegetationChecked || imagery.cementChecked || imagery.shadowChecked || imagery.cementChecked || imagery.sedimentationChecked || imagery.mudFlatsChecked || imagery.redRoofsChecked || imagery.waterDepthChecked))}
                            />
                    </div>
                    <br></br>
                    <label htmlFor="" className="primary">SpaceNetChallenge's <a href="https://github.com/SpaceNetChallenge/BuildingDetectorVisualizer">BuildingDetectorVisualizer</a> - <a href="https://github.com/SpaceNetChallenge/BuildingDetectorVisualizer/blob/master/visualizer-1.1/data/band-triplets.txt">triplets</a></label>
                    <div className="pt-button-group pt-fill">
                        <Button
                            active={imagery.urbanChecked}
                            onClick={this.checkUrban}
                            text="URBAN"
                            className={this.isActive(imagery.urbanChecked)}
                        />
                        <Button
                            active={imagery.blackwaterChecked}
                            onClick={this.checkBlackwater}
                            text="BLACKWATER"
                            className={this.isActive(imagery.blackwaterChecked)}
                        />
                    </div>
                    <div className="pt-button-group pt-fill">
                        <Button
                            active={imagery.ir1Checked}
                            onClick={this.checkIR1}
                            text="IR1"
                            className={this.isActive(imagery.ir1Checked)}
                        />
                        <Button
                            active={imagery.ir2Checked}
                            onClick={this.checkIR2}
                            text="IR2"
                            className={this.isActive(imagery.ir2Checked)}
                        />
                        <Button
                            active={!(imagery.urbanChecked || imagery.blackwaterChecked || imagery.ir1Checked || imagery.ir2Checked)}
                            onClick={this.checkNoImagery}
                            text="OFF"
                            className={this.isActive(!(imagery.urbanChecked || imagery.blackwaterChecked || imagery.ir1Checked || imagery.ir2Checked))}
                        />
                    </div>

                  <label htmlFor="" className="secondary">Opacity</label>
                          <Slider
                              min={0}
                              max={1}
                              stepSize={0.02}
                              renderLabel={false}
                              value={imagery.opacity}
                              onChange={this.handleImageryOpacityChange}
                          />
                </div>

                <div className="option-section">
                    <label htmlFor="" className="primary">Labels</label>
                    <div className="pt-button-group pt-fill">
                        <Button
                            active={labels.checked}
                            onClick={this.checkLabels}
                            text="ON"
                            className={this.isActive(labels.checked)}
                        />
                        <Button
                            active={!labels.checked}
                            onClick={this.checkNoLabels}
                            text="OFF"
                            className={this.isActive(!labels.checked)}
                        />
                    </div>
                    <div className="slider-section">
                        <label htmlFor="" className="secondary">Opacity</label>
                        <Slider
                            min={0}
                            max={1}
                            stepSize={0.02}
                            renderLabel={false}
                            value={labels.opacity}
                            onChange={this.handleLabelsOpacityChange}
                        />
                    </div>
                </div>
            </div>
        );
    }
}

// {modelSections}
// <div className="option-section">
//     <label htmlFor="" className="primary">FCN vs UNET</label>
//     <div className="pt-button-group pt-fill">
//         <Button
//             active={ab.checked}
//             onClick={this.checkAb}
//             text="ON"
//             className={this.isActive(ab.checked)}
//         />
//         <Button
//             active={!ab.checked}
//             onClick={this.checkNoAb}
//             text="OFF"
//             className={this.isActive(!ab.checked)}
//         />
//     </div>
//     <div className="slider-section">
//         <label htmlFor="" className="secondary">Opacity</label>
//         <Slider
//             min={0}
//             max={1}
//             stepSize={0.02}
//             renderLabel={false}
//             value={ab.opacity}
//             onChange={this.handleAbOpacityChange}
//         />
//     </div>
// </div>


SingleLayer.propTypes = {
    dispatch: PropTypes.func.isRequired,
    imagery: PropTypes.object.isRequired,
    dsm: PropTypes.object.isRequired,
    dsmGt: PropTypes.object.isRequired,
    labels: PropTypes.object.isRequired,
    models: PropTypes.object.isRequired
}
