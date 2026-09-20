const states = {
  scheduled: { label: 'On time', island: 'Flight 482 is on time', title: 'Flight 482 is on time', copy: 'Your trip to Toronto is ready. Boarding begins at 9:55 at gate B12.', meta: 'Gate B12', value: 'On schedule', actions: [{ label: 'Simulate disruption', action: 'disrupted' }] },
  disrupted: { label: 'Disrupted', island: 'Flight 482 needs a decision', title: 'Flight 482 is delayed', copy: 'A crew issue adds 55 minutes. You can keep this flight or switch to the 11:20 departure.', meta: 'New departure', value: '10:55', actions: [{ label: 'Take 11:20', action: 'rerouted' }, { label: 'Keep 10:55', action: 'kept' }] },
  rerouted: { label: 'Rerouted', island: 'Agent found a better option', title: 'You are moved to 11:20', copy: 'Your seat is confirmed on flight 618. The agent will keep watching this trip for changes.', meta: 'Flight 618 · Gate C4', value: 'Confirmed', actions: [{ label: 'Resolve thread', action: 'resolved' }] },
  resolved: { label: 'Resolved', island: 'Trip updated successfully', title: 'You are all set', copy: 'Flight 618 is confirmed for 11:20 from gate C4. No further action is needed.', meta: 'Agent thread', value: 'Resolved', actions: [] },
  kept: { label: 'Monitoring', island: 'Agent is monitoring 10:55', title: 'Keeping flight 482', copy: 'Your original flight stays selected. I will keep monitoring it and update this thread if anything changes.', meta: 'Flight 482', value: 'Monitoring', actions: [{ label: 'Resolve thread', action: 'resolved' }] }
};
let current = 'scheduled';
const timeline = document.querySelector('#timeline');
const render = () => {
  const state = states[current];
  document.querySelector('#islandText').textContent = state.island;
  document.querySelector('#notificationTitle').textContent = state.title;
  document.querySelector('#notificationCopy').textContent = state.copy;
  document.querySelector('#metaLabel').textContent = state.meta;
  document.querySelector('#metaValue').textContent = state.value;
  document.querySelector('#timeLabel').textContent = current === 'scheduled' ? 'Now' : 'Updated now';
  document.querySelector('#actions').innerHTML = state.actions.map(item => `<button data-action="${item.action}">${item.label}</button>`).join('');
  timeline.querySelectorAll('button').forEach(button => button.classList.toggle('active', button.dataset.state === current));
};
['scheduled', 'disrupted', 'rerouted', 'resolved'].forEach(key => {
  const button = document.createElement('button');
  button.textContent = states[key].label;
  button.dataset.state = key;
  button.onclick = () => { current = key; render(); };
  timeline.append(button);
});
document.addEventListener('click', event => {
  const action = event.target.dataset.action;
  if (action && states[action]) { current = action; render(); }
});
render();
