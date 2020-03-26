import {AppView} from "../../model/view/AppView"
import {DataDefinitionView, ExtractView, PersistView, TransformView} from "../../model/view/DataDefinitionView"

export const appViewDefaults: AppView = {
    greeting: "",
    data_definitions: [],
}

export const extractViewDefaults: ExtractView = {
    destination: "",
    dictionary: [],
    steps: [],
}

export const transformViewDefaults: TransformView = {
    dictionary: [],
    steps: [],
}

export const persistViewDefaults: PersistView = {
    source: "",
    destination: "",
}


export const dataDefinitionDefaults: DataDefinitionView = {
    dataset_id: "",
    subset_id: "",
    extract: extractViewDefaults,
    transform: transformViewDefaults,
    persist: persistViewDefaults,
}
