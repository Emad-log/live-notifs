const states={
 normal:{island:'UA 837',eyebrow:'FLIGHT STATUS',title:'UA 837 is on time',copy:'Boarding begins at 8:55 PM · Gate B12',label:'Gate B12',value:'On schedule',actions:[]},
 alert:{island:'UA 837 · Delayed',eyebrow:'CONNECTION AT RISK',title:'45m delay detected',copy:'Your Toronto connection may be missed.',label:'Departure',value:'+45 min',actions:[]},
 agent:{island:'Option found · DEN',eyebrow:'AGENT ACTION',title:'UA 1492 via Denver',copy:'A reroute saves your connection.',label:'New connection',value:'Protected',actions:[{text:'Reroute via Denver',next:'processing'}]},
 processing:{island:'Rebooking…',eyebrow:'WORKING ON IT',title:'Rebooking your trip',copy:'Confirming UA 1492 and carrying your connection forward.',label:'Agent action',value:'Processing…',actions:[]},
 done:{island:'Rebooked · UA 1492',eyebrow:'TRIP UPDATED',title:'Connection protected',copy:'Boarding 10:20 PM · Gate C18',label:'UA 1492 · Gate C18',value:'Confirmed',actions:[]}
};
let current='normal',cycle=0;
const $=id=>document.getElementById(id);
function render(){const s=states[current];$('islandText').textContent=s.island;$('eyebrow').textContent=s.eyebrow;$('title').textContent=s.title;$('copy').textContent=s.copy;$('detailLabel').textContent=s.label;$('detailValue').textContent=s.value;$('updated').textContent=current==='normal'?'now':'updated now';$('actions').innerHTML=s.actions.map(a=>`<button data-next="${a.next}">${a.text}</button>`).join('');$('activity').classList.remove('pulse');void $('activity').offsetWidth;$('activity').classList.add('pulse');}
function play(){const token=++cycle;current='normal';render();const steps=[['alert',3000],['agent',6500],['processing',9800],['done',12500]];steps.forEach(([state,delay])=>setTimeout(()=>{if(token===cycle){current=state;render();if(state==='agent')setTimeout(()=>{if(token===cycle){current='processing';render();setTimeout(()=>{if(token===cycle){current='done';render()}},2200)}},2400)}},delay));}
document.addEventListener('click',e=>{const next=e.target.dataset.next;if(next==='processing'){cycle++;current='processing';render();setTimeout(()=>{current='done';render()},2200)}});render();setTimeout(play,1100);setInterval(play,19000);
