"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[265],{3905:(e,n,t)=>{t.d(n,{Zo:()=>p,kt:()=>m});var a=t(67294);function o(e,n,t){return n in e?Object.defineProperty(e,n,{value:t,enumerable:!0,configurable:!0,writable:!0}):e[n]=t,e}function r(e,n){var t=Object.keys(e);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);n&&(a=a.filter((function(n){return Object.getOwnPropertyDescriptor(e,n).enumerable}))),t.push.apply(t,a)}return t}function i(e){for(var n=1;n<arguments.length;n++){var t=null!=arguments[n]?arguments[n]:{};n%2?r(Object(t),!0).forEach((function(n){o(e,n,t[n])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(t)):r(Object(t)).forEach((function(n){Object.defineProperty(e,n,Object.getOwnPropertyDescriptor(t,n))}))}return e}function l(e,n){if(null==e)return{};var t,a,o=function(e,n){if(null==e)return{};var t,a,o={},r=Object.keys(e);for(a=0;a<r.length;a++)t=r[a],n.indexOf(t)>=0||(o[t]=e[t]);return o}(e,n);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);for(a=0;a<r.length;a++)t=r[a],n.indexOf(t)>=0||Object.prototype.propertyIsEnumerable.call(e,t)&&(o[t]=e[t])}return o}var d=a.createContext({}),s=function(e){var n=a.useContext(d),t=n;return e&&(t="function"==typeof e?e(n):i(i({},n),e)),t},p=function(e){var n=s(e.components);return a.createElement(d.Provider,{value:n},e.children)},c="mdxType",w={inlineCode:"code",wrapper:function(e){var n=e.children;return a.createElement(a.Fragment,{},n)}},u=a.forwardRef((function(e,n){var t=e.components,o=e.mdxType,r=e.originalType,d=e.parentName,p=l(e,["components","mdxType","originalType","parentName"]),c=s(t),u=o,m=c["".concat(d,".").concat(u)]||c[u]||w[u]||r;return t?a.createElement(m,i(i({ref:n},p),{},{components:t})):a.createElement(m,i({ref:n},p))}));function m(e,n){var t=arguments,o=n&&n.mdxType;if("string"==typeof e||o){var r=t.length,i=new Array(r);i[0]=u;var l={};for(var d in n)hasOwnProperty.call(n,d)&&(l[d]=n[d]);l.originalType=e,l[c]="string"==typeof e?e:o,i[1]=l;for(var s=2;s<r;s++)i[s]=t[s];return a.createElement.apply(null,i)}return a.createElement.apply(null,t)}u.displayName="MDXCreateElement"},58966:(e,n,t)=>{t.r(n),t.d(n,{assets:()=>d,contentTitle:()=>i,default:()=>w,frontMatter:()=>r,metadata:()=>l,toc:()=>s});var a=t(87462),o=(t(67294),t(3905));const r={sidebar_position:1},i="Opening a window",l={unversionedId:"Windows/opening-a-window",id:"Windows/opening-a-window",title:"Opening a window",description:'In OSGL, a "window" is actually just a fancy name for an EditableImage. All that OSGL does, is wrap this EditableImage in an easy-to-use API for you. With a lot of handy features.',source:"@site/docs/Windows/opening-a-window.md",sourceDirName:"Windows",slug:"/Windows/opening-a-window",permalink:"/osgl-graphics/docs/Windows/opening-a-window",draft:!1,editUrl:"https://github.com/Gunshot-Sound-Studios/osgl-graphics/edit/main/docs/Windows/opening-a-window.md",tags:[],version:"current",sidebarPosition:1,frontMatter:{sidebar_position:1},sidebar:"defaultSidebar",previous:{title:"Setting up your environment",permalink:"/osgl-graphics/docs/setting-up-the-env"},next:{title:"Managing & Rendering to a window",permalink:"/osgl-graphics/docs/Windows/managing-and-rendering-to-a-window"}},d={},s=[],p={toc:s},c="wrapper";function w(e){let{components:n,...t}=e;return(0,o.kt)(c,(0,a.Z)({},p,t,{components:n,mdxType:"MDXLayout"}),(0,o.kt)("h1",{id:"opening-a-window"},"Opening a window"),(0,o.kt)("p",null,'In OSGL, a "window" is actually just a fancy name for an EditableImage. All that OSGL does, is wrap this EditableImage in an easy-to-use API for you. With ',(0,o.kt)("strong",{parentName:"p"},"a lot")," of handy features."),(0,o.kt)("p",null,"Before we can actually ",(0,o.kt)("em",{parentName:"p"},"draw")," on our window, we need to create one. OSGL is split into ",(0,o.kt)("em",{parentName:"p"},"sub-modules")," that each serve a different purpose (e.g, drawing on a window, creating a window, etc.). In this case, we want the ",(0,o.kt)("inlineCode",{parentName:"p"},"Window")," class which allows us to create our window."),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-lua"},"local OSGL = require(ReplicatedStorage.Packages.OSGL)\nlocal Window = OSGL.Window\n")),(0,o.kt)("p",null,"There are two functions available for creating our window: ",(0,o.kt)("inlineCode",{parentName:"p"},"Window.from")," and ",(0,o.kt)("inlineCode",{parentName:"p"},"Window.new")," . According to the API:"),(0,o.kt)("blockquote",null,(0,o.kt)("p",{parentName:"blockquote"},(0,o.kt)("inlineCode",{parentName:"p"},"Window.from")," : ",(0,o.kt)("strong",{parentName:"p"},(0,o.kt)("em",{parentName:"strong"},"Creates an OSGL window from an existing EditableImage.")),"\n",(0,o.kt)("inlineCode",{parentName:"p"},"Window.new")," : ",(0,o.kt)("strong",{parentName:"p"},(0,o.kt)("em",{parentName:"strong"},"Creates an OSGL window by initializing a new EditableImage instance at the specified location.")))),(0,o.kt)("p",null,"Since we don\u2019t have an existing ",(0,o.kt)("inlineCode",{parentName:"p"},"EditableImage")," , we'll use ",(0,o.kt)("inlineCode",{parentName:"p"},"Window.new")," to create our window on the designated ",(0,o.kt)("inlineCode",{parentName:"p"},"ImageLabel"),":"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-lua"},"local OSGL = require(ReplicatedStorage.Packages.OSGL)\nlocal Window = OSGL.Window\n\nlocal windowUi = -- *reference to windowUi, our `ImageLabel`*\n\n-- Create our window, 500x500\nlocal myWindow = Window.new(windowUi, { sizeX = 500, sizeY = 500 })\n")),(0,o.kt)("p",null,"The example above creates an OSGL window, with a size of 500x500, under ",(0,o.kt)("inlineCode",{parentName:"p"},"windowUi"),". You can find more details about this function in the API"),(0,o.kt)("p",null,"And that's it! We have our OSGL window ready and setup for rendering!"))}w.isMDXComponent=!0}}]);