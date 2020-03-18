import {AppView} from "../../model/AppView"
import React, { FunctionComponent, PropsWithChildren } from "react"
import {defaultState} from "../../default-state"
import { Socket, Channel } from "phoenix"

export type PushEvent = (event: any) => void
export type PropsMapper<T> = (state: AppView, pushEvent: PushEvent) => T

export interface AppViewContextProps {
    readonly state: AppView,
    readonly pushEvent: PushEvent
}

export const AppViewContext = React.createContext<{ readonly state: AppView, readonly pushEvent: PushEvent}>({ state: defaultState, pushEvent: () => {}})


export const connect = <T extends {}>(Component: FunctionComponent<T>, propsMapper: PropsMapper<T>) => {
    return class ConnectedComponent extends React.Component<{}, {}> {

        public static readonly contextType = AppViewContext
        public readonly context!: React.ContextType<typeof AppViewContext>

        public render() {
            return <Component {...propsMapper(this.context.state, this.context.pushEvent)}/>
        }
    }
}

export class StateProvider extends React.Component<PropsWithChildren<{}>, { readonly appView: AppView }> {
    // tslint:disable-next-line:readonly-keyword
    private socket: Socket
    // tslint:disable-next-line:readonly-keyword
    private channel: Channel

    constructor(props: {}) {
        super(props)
        this.state = { appView: defaultState }
    }

    componentDidMount() {
        this.socket = new Socket("/socket")
        this.socket.connect()

        this.channel = this.socket.channel("view_messages", {})
        this.channel.on("view_state_update", (appView: AppView) => this.setState({ appView }))
        this.channel.join()
    }


    componentWillUnmount() {
        this.socket.disconnect()
    }

    render() {
        return <AppViewContext.Provider value={{state: this.state.appView, pushEvent: (event) => this.channel.push("ui_event", event) }}>
            {this.props.children}
        </AppViewContext.Provider>
    }

}