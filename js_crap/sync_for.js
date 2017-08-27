var promises = []
for(let i = 0; i < 10; i++) {
  promises.push(new Promise(
    function(resolve, reject) {
      return setTimeout(() => {
        resolve(i)
      }, Math.random() * 1000 + 1000);
    }
  ));
}
Promise.all(promises).then(function(foo) {
  console.log(foo);
});
