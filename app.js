(() => {
  const card = document.querySelector('#card');
  const [base, delay, agent, securing, confirmed] = [...document.querySelectorAll('.state')];
  const button = document.querySelector('.pills button');
  const wait = ms => new Promise(r => setTimeout(r, ms));
  const hide = el => { el.hidden = true; el.style.visibility = 'hidden'; };
  const reveal = el => { el.hidden = false; el.style.visibility = 'visible'; };
  const spring = (from, to, onUpdate, {stiffness=180,damping=.82,mass=1}={}) => new Promise(resolve => {
    let x=from, v=0, last=performance.now();
    const tick = now => { const dt=Math.min((now-last)/1000,.032); last=now; const a=(-stiffness*(x-to)-damping*2*Math.sqrt(stiffness*mass)*v)/mass; v+=a*dt; x+=v*dt; onUpdate(x); if(Math.abs(v)<.02&&Math.abs(x-to)<.02){onUpdate(to);resolve()}else requestAnimationFrame(tick)}; requestAnimationFrame(tick);
  });
  const cross = (out, inc) => { reveal(inc); inc.style.opacity=0; inc.style.filter='blur(4px)'; inc.style.transform='translate3d(0,6px,0)'; return Promise.all([
    out.animate([{opacity:1,filter:'blur(0)',transform:'translate3d(0,0,0)'},{opacity:0,filter:'blur(4px)',transform:'translate3d(0,-6px,0)'}],{duration:360,fill:'both',easing:'ease-in'}).finished,
    inc.animate([{opacity:0,filter:'blur(4px)',transform:'translate3d(0,6px,0)'},{opacity:1,filter:'blur(0)',transform:'translate3d(0,0,0)'}],{duration:620,fill:'both',easing:'cubic-bezier(.22,1,.36,1)'}).finished]); };
  const setHeight = h => spring(card.offsetHeight,h,v=>card.style.height=`${v}px`);
  statesReset();
  function statesReset(){[base,delay,agent,securing,confirmed].forEach(hide); card.style.height='338px'; card.style.opacity=0; card.style.transform='translate3d(0,-88px,0) scale(.96)';}
  async function loop(){
    await spring(0,1,v=>{card.style.opacity=v; card.style.transform=`translate3d(0,${-88*(1-v)}px,0) scale(${.96+.04*v})`},{stiffness:180,damping:.82});
    reveal(base); base.style.opacity=1; await wait(2500);
    await cross(base,delay); delay.animate([{transform:'scale(1)'},{transform:'scale(1.012)'},{transform:'scale(1)'}],{duration:700,easing:'ease-in-out'}); await wait(2000);
    reveal(agent); await setHeight(394); await cross(delay,agent); await wait(2500);
    const tap=document.createElement('span'); tap.className='tap-cursor'; tap.textContent='●'; button.append(tap); await wait(120); tap.classList.add('tap');
    button.animate([{transform:'scale(1)'},{transform:'scale(.94)'},{transform:'scale(1)'}],{duration:300,easing:'cubic-bezier(.22,1,.36,1)'}); await wait(420); tap.remove();
    reveal(securing); await Promise.all([setHeight(338),cross(agent,securing)]); await wait(1000);
    reveal(confirmed); await cross(securing,confirmed); await wait(3500);
    await spring(1,0,v=>{card.style.opacity=v;card.style.transform=`translate3d(0,${-70*(1-v)}px,0) scale(${.975+.025*v})`},{stiffness:210,damping:.9}); statesReset(); await wait(800); loop();
  }
  loop();
})();
