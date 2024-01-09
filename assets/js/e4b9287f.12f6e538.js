"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[797],{3905:(e,n,t)=>{t.d(n,{Zo:()=>d,kt:()=>b});var r=t(67294);function o(e,n,t){return n in e?Object.defineProperty(e,n,{value:t,enumerable:!0,configurable:!0,writable:!0}):e[n]=t,e}function a(e,n){var t=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);n&&(r=r.filter((function(n){return Object.getOwnPropertyDescriptor(e,n).enumerable}))),t.push.apply(t,r)}return t}function i(e){for(var n=1;n<arguments.length;n++){var t=null!=arguments[n]?arguments[n]:{};n%2?a(Object(t),!0).forEach((function(n){o(e,n,t[n])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(t)):a(Object(t)).forEach((function(n){Object.defineProperty(e,n,Object.getOwnPropertyDescriptor(t,n))}))}return e}function l(e,n){if(null==e)return{};var t,r,o=function(e,n){if(null==e)return{};var t,r,o={},a=Object.keys(e);for(r=0;r<a.length;r++)t=a[r],n.indexOf(t)>=0||(o[t]=e[t]);return o}(e,n);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);for(r=0;r<a.length;r++)t=a[r],n.indexOf(t)>=0||Object.prototype.propertyIsEnumerable.call(e,t)&&(o[t]=e[t])}return o}var s=r.createContext({}),u=function(e){var n=r.useContext(s),t=n;return e&&(t="function"==typeof e?e(n):i(i({},n),e)),t},d=function(e){var n=u(e.components);return r.createElement(s.Provider,{value:n},e.children)},m="mdxType",p={inlineCode:"code",wrapper:function(e){var n=e.children;return r.createElement(r.Fragment,{},n)}},c=r.forwardRef((function(e,n){var t=e.components,o=e.mdxType,a=e.originalType,s=e.parentName,d=l(e,["components","mdxType","originalType","parentName"]),m=u(t),c=o,b=m["".concat(s,".").concat(c)]||m[c]||p[c]||a;return t?r.createElement(b,i(i({ref:n},d),{},{components:t})):r.createElement(b,i({ref:n},d))}));function b(e,n){var t=arguments,o=n&&n.mdxType;if("string"==typeof e||o){var a=t.length,i=new Array(a);i[0]=c;var l={};for(var s in n)hasOwnProperty.call(n,s)&&(l[s]=n[s]);l.originalType=e,l[m]="string"==typeof e?e:o,i[1]=l;for(var u=2;u<a;u++)i[u]=t[u];return r.createElement.apply(null,i)}return r.createElement.apply(null,t)}c.displayName="MDXCreateElement"},31875:(e,n,t)=>{t.r(n),t.d(n,{assets:()=>s,contentTitle:()=>i,default:()=>p,frontMatter:()=>a,metadata:()=>l,toc:()=>u});var r=t(87462),o=(t(67294),t(3905));const a={},i="Getting Started",l={unversionedId:"Getting Started",id:"Getting Started",title:"Getting Started",description:"Girra Framework is fast and very good supports intellisense with good debugging and great custom structure simillar to services but not really required. This framework has great things that makes development easier like built-in remote-signals by strings and very great network system that uses bridgenet2.",source:"@site/docs/Getting Started.md",sourceDirName:".",slug:"/Getting Started",permalink:"/Girra-Framework/docs/Getting Started",draft:!1,editUrl:"https://github.com/CubieDays/Girra-Framework/edit/main/docs/Getting Started.md",tags:[],version:"current",frontMatter:{},sidebar:"defaultSidebar",previous:{title:"Debugger",permalink:"/Girra-Framework/docs/Debugging"},next:{title:"Networking",permalink:"/Girra-Framework/docs/Networking"}},s={},u=[{value:"Starting Framework",id:"starting-framework",level:2},{value:"Jobs In General",id:"jobs-in-general",level:2},{value:"Creating Job",id:"creating-job",level:2},{value:"Employees in General",id:"employees-in-general",level:2},{value:"Creating Employees",id:"creating-employees",level:2},{value:"In Job-side",id:"in-job-side",level:3}],d={toc:u},m="wrapper";function p(e){let{components:n,...t}=e;return(0,o.kt)(m,(0,r.Z)({},d,t,{components:n,mdxType:"MDXLayout"}),(0,o.kt)("h1",{id:"getting-started"},"Getting Started"),(0,o.kt)("p",null,"Girra Framework is fast and very good supports intellisense with good debugging and great custom structure simillar to services but not really required. This framework has great things that makes development easier like built-in remote-signals by strings and very great network system that uses bridgenet2."),(0,o.kt)("h2",{id:"starting-framework"},"Starting Framework"),(0,o.kt)("p",null,"Starting Girra Framework in client and server are the same Girra Client and Server have .Start() function which starts the framework althought using it like this Girra.Start() with nothing inside will not do anything you need to setup girra configurations and booleans you can see it in the api or in the debug page whoever you should add a location to your source folder too so it's like Girra.Start(SourceFolder: Instance)"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-lua"},"Girra.Start(ServerScriptService) ({\n    Debugging = {\n        InGameDebugging = {\n            SignalDebugging = true,\n            NetworkDebugging = true,\n            JobDebugging = false,\n            OutputDebugging = false,\n        }\n        InStudioDebugging = {\n            SignalDebugging = true,\n            NetworkDebugging = true,\n            JobDebugging = true,\n            OutputDebugging = true,\n        }\n    }\n})\n")),(0,o.kt)("p",null,"Horray!! we started our framework!\nHowever SourceFolder Should contain various of things.\nAnd they are:"),(0,o.kt)("ul",null,(0,o.kt)("li",{parentName:"ul"},(0,o.kt)("h3",{parentName:"li",id:"jobs-folder"},"Jobs Folder")),(0,o.kt)("li",{parentName:"ul"},(0,o.kt)("h3",{parentName:"li",id:"employees-folder"},"Employees Folder"),"What Jobs? Jobs are things the game is focused on like DataJob or MinigameJob etc.\nWhy Jobs? Simply our country dosen't have alot of jobs and its hard for you to get hired inthere so I just named my structure as Jobs and Employees why not?\nWhat Employees? Employees Used by jobs that can do not more than one operation they are used in heartbeats and steps alot but you can use them in sync or any ways and they simplify for you reading jobs")),(0,o.kt)("h2",{id:"jobs-in-general"},"Jobs In General"),(0,o.kt)("p",null,"Jobs shouldn't be alot because they are the core things of the game and you create them For necessity\nlike if you started your game and you need to create a data for the player you create A dataJob that stores and handles data you mustn't spam Jobs and place alot of methods instead you can create a 2 jobs that classes can use or employees that the 2 jobs can use."),(0,o.kt)("h2",{id:"creating-job"},"Creating Job"),(0,o.kt)("p",null,"To create job you use the Girra.CreateJob() (table: {any}) and place some default and custom methods and properties for properties you must put a name for the job in the table for the methods you can use OnInit for initallizing job and OnStart for Starting job and u can use onstep for loops or onheart for loops but for heartbeat and if you are on client u can use OnRender which all have argument of DeltaTime."),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-lua"},'local Job = Girra.CreateJob() ({ Name = "MyJob" })\nreturn Job\n')),(0,o.kt)("p",null,"Althought this way is not great and bad for intellisense you can use a better and easy trick to get intellisense"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-lua"},'local Job = { Name = "MyJob" }\nGirra.CreateJob() (Job)\nreturn Job\n')),(0,o.kt)("p",null,"Now! this can work with require() and give intellisense!\nFor functions we can put them like this:"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-lua"},'local Job = { Name = "MyJob" }\n\nfunction Job:OnInit() --\x3e Runs when job initallizes\n    Job.Hire("MyEmploy")\nend\n\nfunction Job:OnStart() --\x3e Runs when job starts\n    Job.Employees.MyEmploy.Work()\nend\n\nfunction Job:OnStep(DeltaTime: number) --\x3e Runs every step\n    print(DeltaTime)\nend\n\nfunction Job:OnHeart(DeltaTime: number) --\x3e Runs every heartbeat\n    print(DeltaTime)\nend\n\nfunction Job:OnRender(DeltaTime: number) --\x3e Runs every RenderStep\n    print(DeltaTime, "Client Only")\nend\n\nGirra.CreateJob() (Job)\nreturn Job\n')),(0,o.kt)("p",null,"Great now we put methods and describe them now lets go into Employees."),(0,o.kt)("h2",{id:"employees-in-general"},"Employees in General"),(0,o.kt)("p",null,"Employees, Employees follows jobs they can't do anything with out jobs, you can describe jobs and employees as high classes an employee should get hired from a job and then the job can make him work with .Work() currently Employees arent ready for real use or its rare to find a usecase for them but, we plan for updates on them like giving employees taskes to work on them or something like that"),(0,o.kt)("h2",{id:"creating-employees"},"Creating Employees"),(0,o.kt)("p",null,"Same as creating job but this time you don't need to use intellisense way since Employees have only 2 functions and they are OnHire() and OnWork()"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-lua"},'local Employee = Girra.CreateEmployee() ({ \n    Name = "MyJob" \n})\n\nfunction Employee:OnWork()\n    print("I am working!")\nend\n\nfunction Employee:OnHire()\n    print("I Got Hired!")\nend\n\nreturn Employee\n')),(0,o.kt)("h3",{id:"in-job-side"},"In Job-side"),(0,o.kt)("p",null,"Hiring and Firing in Job-Side to Hire an employee you simply do Job.Hire(EmployName) and to fire an employee and remove it you do Job.Fire(EmployName)."),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-lua"},'local Job = { Name = "MyJob" }\n\nfunction Job:OnInit() --\x3e Runs when job initallizes\n    Job.Hire("MyEmploy") --\x3e Hiring employe\nend\n\nfunction Job:OnStart() --\x3e Runs when job starts\n    Job.Employees.MyEmploy.Work() --\x3e First way\n    task.wait(5)\n\n    Job.Fire("MyEmploy")\nend\n\nfunction Job:OnStep(DeltaTime: number) --\x3e Runs every step\n    print(DeltaTime)\nend\n\nGirra.CreateJob() (Job)\nreturn Job\n')),(0,o.kt)("p",null,"Horray, this is the first way to get a job and hire it but the second one is easier."),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-lua"},'local Job = { Name = "MyJob" }\nlocal Employees = {\n\n}\n\nfunction Job:OnInit() --\x3e Runs when job initallizes\n   Employees.MyEmployee = Job.Hire("MyEmploy") --\x3e Hiring employe\nend\n\nfunction Job:OnStart() --\x3e Runs when job starts\n    Employees.MyEmployee.Work() --\x3e First way\n    task.wait(5)\n\n    Job.Fire("MyEmploy")\nend\n\nfunction Job:OnStep(DeltaTime: number) --\x3e Runs every step\n    print(DeltaTime)\nend\n\nGirra.CreateJob() (Job)\nreturn Job\n')))}p.isMDXComponent=!0}}]);