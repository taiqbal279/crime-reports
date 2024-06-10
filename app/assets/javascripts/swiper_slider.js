$(document).ready(function () {
  //initialize swiper when document ready
  var swiper = new Swiper('.swiper-container', {
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    },
    autoplay: {
      delay: 5000,
      disableOnInteraction: false
    },
    freeMode: true,
    loop: true,
    on: {
      init: function() {
        checkArrow();
      },
      resize: function () {
        checkArrow();
      }
    }
  });

  var awardsSwiper = new Swiper('.swiper-container-awards', {
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    },
    slidesPerView: 1,
    loopFillGroupWithBlank: false,
    autoplay: {
      delay: 5000,
      disableOnInteraction: false
    },
    freeMode: true,
    loop: true,
    on: {
      init: function() {
        checkArrow();
      },
      resize: function () {
        checkArrow();
      }
    }
  });

  function checkArrow() {
    var swiperPrev = $('.swiper-button-prev');
    var swiperNext = $('.swiper-button-next');
    if ( window.innerWidth > 1024  ) {
      console.log('Success', window.innerWidth);
      swiperPrev.show();
      swiperNext.show();
    } else {
      swiperPrev.hide();
      swiperNext.hide();
    }
  }
});

