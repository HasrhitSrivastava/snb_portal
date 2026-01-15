document.addEventListener('DOMContentLoaded', () => {
    const nav = document.querySelector('.main-nav');
    const menuToggle = document.querySelector('.menu-toggle');
    const ticker = document.getElementById('announcement-ticker');

    // 1. Mobile Menu Toggle
    if (menuToggle) {
        menuToggle.addEventListener('click', () => {
            // Toggles a CSS class to show/hide the navigation
            nav.classList.toggle('is-open'); 
        });
    }

    // Add CSS for .main-nav.is-open for mobile display:
    /*
    @media (max-width: 768px) {
        .main-nav.is-open {
            display: block;
            position: absolute;
            top: 60px; // Adjust based on header height
            left: 0;
            right: 0;
            background-color: white;
            z-index: 10;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .main-nav.is-open ul {
            flex-direction: column;
        }
    }
    */


    // 2. Announcement Ticker/Scroller Effect
    if (ticker) {
        // Simple CSS-based scrolling animation is easier, but if you need JS:
        let position = 0;
        const speed = 0.5; // Pixels per frame

        function scrollTicker() {
            position -= speed;
            if (position < -ticker.scrollWidth + ticker.offsetWidth) {
                position = 0; // Reset position when content scrolls out
            }
            ticker.style.transform = `translateX(${position}px)`;
            requestAnimationFrame(scrollTicker);
        }

        // If the content is wider than the container, start scrolling
        if (ticker.scrollWidth > ticker.offsetWidth) {
             // Use CSS animation for true continuous loop (best practice), but this works:
             // scrollTicker();
             ticker.style.animation = 'scroll-left 20s linear infinite';
        }

        // You would need this CSS keyframe for the clean loop:
        /*
        @keyframes scroll-left {
            0% { transform: translateX(100%); }
            100% { transform: translateX(-100%); }
        }
        */
    }

    document.addEventListener('DOMContentLoaded', function() {
        const toggleButton = document.querySelector('.menu-toggle');
        const mainNav = document.querySelector('.main-nav');

        // Check if both elements exist before adding the listener
        if (toggleButton && mainNav) {
            toggleButton.addEventListener('click', function() {
                // This line Toggles the 'open' class on the navigation element
                mainNav.classList.toggle('open'); 
                
                // OPTIONAL: Update the button's ARIA state for accessibility
                const isExpanded = mainNav.classList.contains('open');
                this.setAttribute('aria-expanded', isExpanded);
            });
        }
    });
});