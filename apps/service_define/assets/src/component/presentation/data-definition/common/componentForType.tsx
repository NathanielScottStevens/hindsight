import React from "react"
import {ModuleFunctionArgs} from "./ModuleFunctionArgs"
import {
    ArgumentType,
    isListArgumentType,
    ModuleFunctionArgsView,
    PrimitiveArgumentType
} from "../../../../model/view/ModuleFunctionArgsView"
import {Map} from "./Map"
import {List} from "./List"
import { ObjectMap } from "../../../../model/ObjectMap"

export type ValueComponent<T> = (props: { readonly value: T }) => JSX.Element

export const componentForType = (type: ArgumentType): ValueComponent<any> => {
    if(isListArgumentType(type)) {
        return ListWrapper
    } else {
        switch (type) {
            case PrimitiveArgumentType.module: return ModuleFunctionArgsWrapper
            case PrimitiveArgumentType.map: return MapWrapper
            case PrimitiveArgumentType.map: return MapWrapper
            default: return StringWrapper
        }
    }
}

const StringWrapper: ValueComponent<string> =
    ({value}) => <>{value.toString()}</>

const ModuleFunctionArgsWrapper: ValueComponent<readonly ModuleFunctionArgsView[]> =
    ({value}) => <>{value.map((value, index) => <span key={index}><ModuleFunctionArgs{...value}/><br/></span>)}</>

const MapWrapper: ValueComponent<ObjectMap<string>> =
    ({value}) => <Map object={value}/>

const ListWrapper: ValueComponent<readonly string[]> =
    ({value}) => <List list={value}/>