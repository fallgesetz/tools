
for(let i = 0; i < 10; i++) {
setTimeout(() => {
  console.log(i)
}, Math.random() * 1000 + 1000);
}
