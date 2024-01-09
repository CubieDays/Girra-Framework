"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[933],{3905:(e,n,t)=>{t.d(n,{Zo:()=>u,kt:()=>f});var a=t(67294);function r(e,n,t){return n in e?Object.defineProperty(e,n,{value:t,enumerable:!0,configurable:!0,writable:!0}):e[n]=t,e}function i(e,n){var t=Object.keys(e);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);n&&(a=a.filter((function(n){return Object.getOwnPropertyDescriptor(e,n).enumerable}))),t.push.apply(t,a)}return t}function l(e){for(var n=1;n<arguments.length;n++){var t=null!=arguments[n]?arguments[n]:{};n%2?i(Object(t),!0).forEach((function(n){r(e,n,t[n])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(t)):i(Object(t)).forEach((function(n){Object.defineProperty(e,n,Object.getOwnPropertyDescriptor(t,n))}))}return e}function o(e,n){if(null==e)return{};var t,a,r=function(e,n){if(null==e)return{};var t,a,r={},i=Object.keys(e);for(a=0;a<i.length;a++)t=i[a],n.indexOf(t)>=0||(r[t]=e[t]);return r}(e,n);if(Object.getOwnPropertySymbols){var i=Object.getOwnPropertySymbols(e);for(a=0;a<i.length;a++)t=i[a],n.indexOf(t)>=0||Object.prototype.propertyIsEnumerable.call(e,t)&&(r[t]=e[t])}return r}var s=a.createContext({}),c=function(e){var n=a.useContext(s),t=n;return e&&(t="function"==typeof e?e(n):l(l({},n),e)),t},u=function(e){var n=c(e.components);return a.createElement(s.Provider,{value:n},e.children)},d="mdxType",g={inlineCode:"code",wrapper:function(e){var n=e.children;return a.createElement(a.Fragment,{},n)}},p=a.forwardRef((function(e,n){var t=e.components,r=e.mdxType,i=e.originalType,s=e.parentName,u=o(e,["components","mdxType","originalType","parentName"]),d=c(t),p=r,f=d["".concat(s,".").concat(p)]||d[p]||g[p]||i;return t?a.createElement(f,l(l({ref:n},u),{},{components:t})):a.createElement(f,l({ref:n},u))}));function f(e,n){var t=arguments,r=n&&n.mdxType;if("string"==typeof e||r){var i=t.length,l=new Array(i);l[0]=p;var o={};for(var s in n)hasOwnProperty.call(n,s)&&(o[s]=n[s]);o.originalType=e,o[d]="string"==typeof e?e:r,l[1]=o;for(var c=2;c<i;c++)l[c]=t[c];return a.createElement.apply(null,l)}return a.createElement.apply(null,t)}p.displayName="MDXCreateElement"},54901:(e,n,t)=>{t.r(n),t.d(n,{assets:()=>s,contentTitle:()=>l,default:()=>g,frontMatter:()=>i,metadata:()=>o,toc:()=>c});var a=t(87462),r=(t(67294),t(3905));const i={sidebar_position:4},l="Signals",o={unversionedId:"Signals",id:"Signals",title:"Signals",description:"Our Event Connection Methods is simillar to RBXScriptSignal by Roblox it's a class which fires data listens to a callback function and transfer data from script to script or modulescript to script.",source:"@site/docs/Signals.md",sourceDirName:".",slug:"/Signals",permalink:"/Girra-Framework/docs/Signals",draft:!1,editUrl:"https://github.com/CubieDays/Girra-Framework/edit/main/docs/Signals.md",tags:[],version:"current",sidebarPosition:4,frontMatter:{sidebar_position:4},sidebar:"defaultSidebar",previous:{title:"Getting Started",permalink:"/Girra-Framework/docs/Getting Started"},next:{title:"Networking",permalink:"/Girra-Framework/docs/Networking"}},s={},c=[{value:"Transfering Data ( Firing )",id:"transfering-data--firing-",level:2},{value:"Refrenced Signal",id:"refrenced-signal",level:3},{value:"unRefrencedSignal",id:"unrefrencedsignal",level:3},{value:"Why Refrenced and UnRefrenced?",id:"why-refrenced-and-unrefrenced",level:2},{value:"Transfering Data ( Firing )",id:"transfering-data--firing--1",level:3},{value:"Receiving Data ( Listening )",id:"receiving-data--listening-",level:2},{value:"Transfering on creator script",id:"transfering-on-creator-script",level:2},{value:"Receiving on creator script",id:"receiving-on-creator-script",level:2}],u={toc:c},d="wrapper";function g(e){let{components:n,...t}=e;return(0,r.kt)(d,(0,a.Z)({},u,t,{components:n,mdxType:"MDXLayout"}),(0,r.kt)("h1",{id:"signals"},"Signals"),(0,r.kt)("p",null,"Our Event Connection Methods is simillar to RBXScriptSignal by Roblox it's a class which fires data listens to a callback function and transfer data from script to script or modulescript to script. "),(0,r.kt)("h2",{id:"transfering-data--firing-"},"Transfering Data ( Firing )"),(0,r.kt)("p",null,"To transfer data first we need to create our signal but before that we should introduce you refrencedSignal and UnrefrencedSignal."),(0,r.kt)("h3",{id:"refrenced-signal"},"Refrenced Signal"),(0,r.kt)("p",null,"A refrenced signal is a signal that you can use by name and get it by name\ncreating it is by using the girra's .CreateSignal(Name: string?) expect that you put a name in the arg1 as it's not required not putting a name will create an unRefrencedSignal."),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-lua"},'local RefrencedSignal = Girra.CreateSignal("RefrencedSignal")\n')),(0,r.kt)("h3",{id:"unrefrencedsignal"},"unRefrencedSignal"),(0,r.kt)("p",null,"An unRefrencedSignal is a signal that does not have a name and should be stored somewhere to get it\nCreating an unRefrencedSignal is simple use the girra's .CreateSignal(Name: string?) expect the opposite from RefrencedSignal you don't put anything on arg1 or nil."),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-lua"},'local RefrencedSignal = Girra.CreateSignal("RefrencedSignal")\n')),(0,r.kt)("p",null,"And Then you can get it from other scripts by girra's .GetSignal(Name: string)"),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-lua"},'local RefrencedSignal = Girra.GetSignal("RefrencedSignal")\n')),(0,r.kt)("h2",{id:"why-refrenced-and-unrefrenced"},"Why Refrenced and UnRefrenced?"),(0,r.kt)("p",null,"When you are trying to get a signal by the fastest way without getting it from a stored table you use strings and thats always the better but what's about UnRefrenced? unrefrencedSignal is always used for ( Classes ) and should only be like if you are making a car a good developer should know that classes will make his development easier and use Classes but alot of developers use methods for classes only if you look at roblox's part instance you should know it's in scripting is just a table that stores properties, Childerens but Part instance have: Methods, Properties, RBXScriptSignals making a car class with signals will make you comfortable and looks like you created a custom instance that's cool with properties and methods and Signals."),(0,r.kt)("h3",{id:"transfering-data--firing--1"},"Transfering Data ( Firing )"),(0,r.kt)("p",null,"To transfer data you need to CreateSignal and then use the :Fire(Content: any | { any }) Method.\nWith your data in content which is 1 argument and not a tuple if you want to send multiple data use Table."),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-lua"},'local Girra = require("Path.To.Girra")\n\nlocal Signal = Girra.CreateSignal()\n\nSignal:Fire("Hello World!")\nSignal:Fire({\n    "This is my data"\n})\n')),(0,r.kt)("h2",{id:"receiving-data--listening-"},"Receiving Data ( Listening )"),(0,r.kt)("p",null,"To recieve data you need to GetSignal or Create then use the :Listen(Callback: (Content: any | {any}))"),(0,r.kt)("pre",null,(0,r.kt)("code",{parentName:"pre",className:"language-lua"},'local Girra = require("Path.To.Girra")\n\nlocal Signal = Girra.CreateSignal()\n\nSignal:Listen(function(Content: {any} | any) \n    print(Content)\nend)\n')),(0,r.kt)("h2",{id:"transfering-on-creator-script"},"Transfering on creator script"),(0,r.kt)("p",null,"Transfering on creator script means creating a signal and transfering data in the same script before doing that you should listen as if you fire before listening data will not send to the listened callback function so you do these instructions:"),(0,r.kt)("ul",null,(0,r.kt)("li",{parentName:"ul"},"Create Signal"),(0,r.kt)("li",{parentName:"ul"},"Wait for Listening"),(0,r.kt)("li",{parentName:"ul"},"Transfer Data")),(0,r.kt)("h2",{id:"receiving-on-creator-script"},"Receiving on creator script"),(0,r.kt)("p",null,"You shouldn't worry on Receiving on creatorscript but you should becareful on waiting a bit of time and listen after couple of seconds after creating signal as if the other scripts fire data it will not recieve so you do these instructions:"),(0,r.kt)("ul",null,(0,r.kt)("li",{parentName:"ul"},"Create Signal"),(0,r.kt)("li",{parentName:"ul"},"Listen Immediately")))}g.isMDXComponent=!0}}]);