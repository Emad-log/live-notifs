(() => {
  const card = document.querySelector('#card');
  const states = [...document.querySelectorAll('.state')];
  const [base, delay, agent, securing, confirmed] = states;
  const button = document.querySelector('.pills button');
  const wait = ms => new Promise(resolve => setTimeout(resolve, ms));
  const animate = (el, keyframes, options) => el.animate(keyframes, { fill: 'both', ...options }).finished;
  const show = el => { el.hidden = false; el.style.visibility = 'visible'; };
  const hide = el => { el.style.visibility = 'hidden'; el.hidden = true; };
  const fade = (el, opacity, y = 0, duration = 500, easing = 'cubic-bezier(.22,1,.36,1)') => animate(el, [{ opacity: getComputedStyle(el).opacity, transform: `translate3d(0,${y}px,0)` }, { opacity, transform: 'translate3d(0,0,0)' }], { duration, easing });

  states.forEach(hide);
  card.style.opacity = '0';
  card.style.transform = 'translate3d(0,-76px,0) scale(.965)';

  async function loop() {
    await animate(card, [{ opacity: 0, transform: 'translate3d(0,-76px,0) scale(.965)' }, { opacity: 1, transform: 'translate3d(0,0,0) scale(1)' }], { duration: 980, easing: 'cubic-bezier(.16,1,.3,1)' });
    show(base); base.style.opacity = '1'; base.style.transform = 'none';
    await wait(1900);
    show(delay);
    await Promise.all([fade(base, 0, -8, 420), fade(delay, 1, 8, 520)]);
    delay.animate([{ transform: 'scale(1)' }, { transform: 'scale(1.012)' }, { transform: 'scale(1)' }], { duration: 680, easing: 'ease-in-out' });
    await wait(1200);
    show(agent); agent.style.opacity = '0'; agent.style.transform = 'translate3d(0,12px,0)';
    await fade(agent, 1, 12, 560);
    await wait(700);
    button.animate([{ transform: 'scale(1)' }, { transform: 'scale(.94)' }, { transform: 'scale(1)' }], { duration: 310, easing: 'cubic-bezier(.22,1,.36,1)' });
    await wait(360);
    show(securing); securing.style.opacity = '0';
    await Promise.all([fade(agent, 0, -8, 330), fade(securing, 1, 8, 400)]);
    await wait(1450);
    show(confirmed); confirmed.style.opacity = '0';
    await Promise.all([fade(securing, 0, -6, 300), fade(confirmed, 1, 8, 560)]);
    await wait(2500);
    await animate(card, [{ opacity: 1, transform: 'translate3d(0,0,0) scale(1)' }, { opacity: 0, transform: 'translate3d(0,-66px,0) scale(.975)' }], { duration: 820, easing: 'cubic-bezier(.7,0,.84,0)' });
    states.forEach(hide); card.style.opacity = '0'; card.style.transform = 'translate3d(0,-76px,0) scale(.965)';
    await wait(700); loop();
  }
  loop();
})();
