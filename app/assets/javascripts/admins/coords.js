function pr(e){console.log(e);}
var coords={initialOptions:{'spaces':true,'degrees':true,'minutes':true,'seconds':true,'degreeIndicator':'Â°','minuteIndicator':"'",'secondIndicator':'"','showSign':false,'showCompassDirection':true,'decimalSeparator':'.','decimalPlaces':5,//@todo: permitir renomear as direÃ§Ãµes exibidas
//@todo: Exibir um Ã­cone Ã  direita do campo que permita abrir uma popup e selecionar a localizaÃ§Ã£o no mapa
'recalculateWidth':true,'pixelsBychars':8,'saveFormatOptions':null,'pasteErrorMessage':'The pasted texto isn\'t a valid coordinate',},init:function(strSelector,options){var $obj=this;this.initialOptions=this.options(options);if(this.saveFormatOptions==null){this.setSaveFormat(this.initialOptions);}
var inputs=document.querySelectorAll(strSelector);for(i=0;i<inputs.length;i++){$obj.makeAllEverythingAndOthers(inputs[i]);}
return this;},makeAllEverythingAndOthers:function(objInput){var options=this.initialOptions;objInput.style.display='none';var inputName=objInput.getAttribute('name');var showIconClass=this.options.showIcon?'coords-show-icon-map':'';var objContainer=document.createElement('DIV');objContainer.className='coords-container '+ showIconClass+' ';objInput.parentNode.insertBefore(objContainer,objInput.nextSibling);if(options.showSign==true){this.createSelect(objContainer,inputName,'signal',['','+','-']);}
this.createElement(objContainer,inputName,'degrees',options.degreeIndicator)
if(options.minutes==true||options.seconds==true){this.createElement(objContainer,inputName,'minutes',options.minuteIndicator)}
if(options.seconds==true){this.createElement(objContainer,inputName,'seconds',options.secondIndicator)}
if(options.showCompassDirection==true){this.createSelect(objContainer,inputName,'compass',['','E','N','S','W']);}
this.setInitialValues(objInput);},createElement:function(objContainer,inputName,coordsType,indicator){var input=document.createElement('INPUT');input.setAttribute('type','text');input.setAttribute('data-coords-type',coordsType);input.setAttribute('name',inputName+'_coords_'+ coordsType);input.setAttribute('class','coords-input coords-'+ coordsType);objContainer.appendChild(input);this.eventsHandler(input);var span=document.createElement('SPAN');span.setAttribute('class','coords-indicator coords-'+ coordsType);span.innerHTML=indicator;objContainer.appendChild(span);},createSelect:function(objContainer,inputName,selectType,data){var select=document.createElement('SELECT');select.setAttribute('name',inputName+'_'+ selectType);select.setAttribute('class','coords-select coords-'+ selectType);select.setAttribute('data-coords-type',selectType);objContainer.appendChild(select);for(var i=0;i<data.length;i++){var opt=document.createElement('option');opt.innerHTML=data[i];opt.value=data[i];select.appendChild(opt);}
this.eventsHandler(select);},batchValues:function($objInput,strCoord){var parse=this.parse(strCoord);if(parse==false)return false;var children=$objInput.nextSibling.children
for(i=0;i<children.length;i++){switch(children[i].getAttribute('data-coords-type')){case'signal':children[i].value=parse.signal;break;case'compass':children[i].value=parse.compass;break;case'degrees':children[i].value=Number.isInteger(parse.degrees)===true?parse.degrees:parse.degrees.toFixed(this.initialOptions.decimalPlaces);break;case'minutes':children[i].value=Number.isInteger(parse.minutes)===true?parse.minutes:parse.minutes.toFixed(this.initialOptions.decimalPlaces);break;case'seconds':children[i].value=Number.isInteger(parse.seconds)===true?parse.seconds:parse.seconds.toFixed(this.initialOptions.decimalPlaces);break;}}
return true;},setInitialValues:function(objInput){if(typeof objInput=='object'&&objInput.tagName=='INPUT'&&objInput.value!==''){this.batchValues(objInput,objInput.value);this.calculateWidths(objInput);objInput.setAttribute('value',this.convert(objInput.value,this.saveFormatOptions));}},setSaveFormat:function(options){this.saveFormatOptions=this.options(options);},calculateWidths:function(objInput){if(this.initialOptions.recalculateWidth!==true)return;var pixelsBychars=this.initialOptions.pixelsBychars||8;var children=objInput.nextSibling.children;for(i=0;i<children.length;i++){if(children[i].getAttribute('class').search('coords-input')!==-1){children[i].style.width=((children[i].value.length+ 1)*pixelsBychars)+'px';}
else if(children[i].getAttribute('class').search('coords-select')!==-1){children[i].style.width='35px';}}},eventsHandler:function(objInput){var $this=this;objInput.addEventListener('paste',function(evnt){$this.onPaste(evnt,$this)});objInput.addEventListener('focus',function(evnt){$this.onFocus(evnt,$this)});objInput.addEventListener('keydown',function(evnt){$this.onKeydown(evnt,$this)});objInput.addEventListener('change',function(evnt){$this.onChange(evnt,$this)});objInput.addEventListener('copy',function(evnt){$this.onCopy(evnt,$this)});},onCopy:function(evnt,$this){evnt.clipboardData.setData('text/plain',$this.inputToString(evnt.target.parentNode.previousSibling));evnt.preventDefault();},onChange:function(evnt,$this){var $container=evnt.target.parentNode;var $children=$container.children;var $input=$container.previousSibling;var strCoord='';for(i=0;i<$children.length;i++){if($children[i].tagName=='INPUT'||$children[i].tagName=='SELECT'){strCoord+=(typeof $children[i].value=='undefined'?'0':$children[i].value)+' ';}}
$input.setAttribute('value',$this.convert(strCoord,$this.saveFormatOptions));},onKeydown:function(evnt,$this){if(evnt.target.tagName=='INPUT'&&(evnt.keyCode>=48&&evnt.keyCode<=57||evnt.keyCode==188||evnt.keyCode==190)){$this.calculateWidths(evnt.target.parentNode.previousSibling);}},onFocus:function(evnt,$this){evnt.stopPropagation();evnt.preventDefault();if(evnt.target.tagName=='INPUT'){evnt.target.select();}},onPaste:function(evnt,$this){var clipboardData,pastedData;evnt.stopPropagation();evnt.preventDefault();clipboardData=evnt.clipboardData||window.clipboardData;pastedData=clipboardData.getData('Text');if($this.batchValues(evnt.target.parentNode.previousSibling,pastedData)===false){alert($this.initialOptions.pasteErrorMessage)}
$this.calculateWidths(evnt.target.parentNode.previousSibling);},options:function(options){if(typeof options=='undefined')return this.initialOptions;options.degrees=true;if(options.minutes==false)options.seconds=false;options=Object.assign({},this.initialOptions,options);return options;},normalize:function(strCoord){strCoord=strCoord.replace(/\s{2,}/g," ")
strCoord=strCoord.replace(/[Â°Ëšâ°âˆ˜â—¦à¥°Âºo]+/g,'Â°')
strCoord=strCoord.replace(/['Ê¹Ê¼Ëˆ×³â€²êžŒ]{1}/g,"'")
strCoord=strCoord.replace("''",'"')
strCoord=strCoord.replace(/["â€žâ€œâ€]+/g,'"')
strCoord=strCoord.replace(/\,+/g,'.')
return strCoord;},parse:function(strCoord){strCoord=this.normalize(strCoord);var pattern=/([NEWS]{1}|[-+]{1})?\s*([0-9,\.]+\s*Â°?)\s*([0-9,\.]+\s*'?)?\s*([0-9,\.]+\s*"?)?\s*([NEWS]{1})?/i
var parts=pattern.exec(strCoord);if(parts==null)return false;var compassDirections=['N','E','W','S'];var hasCompass=compassDirections.indexOf(parts[1])!==-1?parts[1].toUpperCase():(compassDirections.indexOf(parts[5])!==-1?parts[5]:false)
var hasSignal=parts[1]=='-'||['S','W'].indexOf(hasCompass)!==-1?'-':'+';var degrees=typeof parts[2]!=='undefined'?parseFloat(parts[2]):0;var minutes=typeof parts[3]!=='undefined'?parseFloat(parts[3]):0;var seconds=typeof parts[4]!=='undefined'?parseFloat(parts[4]):0;if(minutes===0&&seconds===0&&(degrees!==parseInt(degrees))){minutes=(degrees- parseInt(degrees))*60;degrees=parseInt(degrees);}
if(seconds===0&&(minutes!==parseInt(minutes))){seconds=(minutes- parseInt(minutes))*60;minutes=parseInt(minutes)}
return{signal:hasSignal,compass:hasCompass,degrees:degrees,minutes:minutes,seconds:seconds,};},stringToDecimal:function(strCoord){return this.convert(strCoord,{'degrees':true,'minutes':false,'seconds':false,'showSign':true,'spaces':false,'degreeIndicator':'','showCompassDirection':false});},convert:function(strCoord,options){return this.parseObjectToString(this.parse(strCoord),options);},inputToString:function(input,options){input=(typeof input=='string')?document.querySelector(input):input;options=this.options(options);if(input.tagName!=='INPUT'){console.log('"input" parameter isn\'t a valid input object');return false;}
var $container=input.nextSibling;var $children=$container.children;var strCoord='';for(i=0;i<$children.length;i++){if($children[i].tagName=='INPUT'){strCoord+=($children[i].value==''?0:$children[i].value);}
else if($children[i].tagName=='SELECT'&&$children[i].value!==""){strCoord+=$children[i].value;}
else{continue;}
strCoord+=' ';}
return this.convert(strCoord,options);},parseObjectToString:function(objParse,options){var newOptions=this.options(options);if(newOptions.seconds==false){objParse.minutes=objParse.minutes+(objParse.seconds/60);objParse.seconds=false;}
if(newOptions.minutes==false){objParse.degrees=objParse.degrees+(objParse.minutes/60);objParse.minutes=false;}
var spaces=newOptions.spaces?' ':'';return((newOptions.showSign?objParse.signal+ spaces:'')
+ objParse.degrees+ newOptions.degreeIndicator
+(newOptions.minutes==true?spaces+ objParse.minutes+ newOptions.minuteIndicator:'')
+(newOptions.seconds==true?spaces+ objParse.seconds+ newOptions.secondIndicator:'')
+(newOptions.showCompassDirection&&objParse.compass?spaces+ objParse.compass:'')).replace(/[,\.]+/g,newOptions.decimalSeparator).trim();},};if(window.jQuery){jQuery.fn.extend({'coords':function(options){coords.init(this.selector,options);return this;},});$(function(){});}