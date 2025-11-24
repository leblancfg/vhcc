// Smooth scroll for anchor links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// Highlight current slide on scroll
const slides = document.querySelectorAll('.slide');
const slideNumbers = document.querySelectorAll('.slide-number');

function updateActiveSlide() {
    let currentSlide = 0;
    const scrollPosition = window.scrollY + window.innerHeight / 2;

    slides.forEach((slide, index) => {
        const slideTop = slide.offsetTop;
        const slideBottom = slideTop + slide.offsetHeight;

        if (scrollPosition >= slideTop && scrollPosition < slideBottom) {
            currentSlide = index;
        }
    });

    slideNumbers.forEach((number, index) => {
        if (index === currentSlide) {
            number.style.color = 'var(--cyan)';
            number.style.fontWeight = '700';
        } else {
            number.style.color = 'var(--fg-dim)';
            number.style.fontWeight = '400';
        }
    });
}

// Throttle scroll events for better performance
let scrollTimeout;
window.addEventListener('scroll', () => {
    if (scrollTimeout) {
        window.cancelAnimationFrame(scrollTimeout);
    }
    scrollTimeout = window.requestAnimationFrame(updateActiveSlide);
});

// Initial check
updateActiveSlide();

// Add keyboard navigation (arrow keys)
document.addEventListener('keydown', (e) => {
    if (e.key === 'ArrowDown' || e.key === 'ArrowRight') {
        e.preventDefault();
        const currentSlide = getCurrentSlide();
        if (currentSlide < slides.length - 1) {
            slides[currentSlide + 1].scrollIntoView({ behavior: 'smooth' });
        }
    } else if (e.key === 'ArrowUp' || e.key === 'ArrowLeft') {
        e.preventDefault();
        const currentSlide = getCurrentSlide();
        if (currentSlide > 0) {
            slides[currentSlide - 1].scrollIntoView({ behavior: 'smooth' });
        }
    } else if (e.key === 'Home') {
        e.preventDefault();
        slides[0].scrollIntoView({ behavior: 'smooth' });
    } else if (e.key === 'End') {
        e.preventDefault();
        slides[slides.length - 1].scrollIntoView({ behavior: 'smooth' });
    }
});

function getCurrentSlide() {
    const scrollPosition = window.scrollY + window.innerHeight / 2;
    let currentSlide = 0;

    slides.forEach((slide, index) => {
        const slideTop = slide.offsetTop;
        const slideBottom = slideTop + slide.offsetHeight;

        if (scrollPosition >= slideTop && scrollPosition < slideBottom) {
            currentSlide = index;
        }
    });

    return currentSlide;
}

// Add fade-in animation on scroll
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -100px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, observerOptions);

// Apply animation to cards and content
document.querySelectorAll('.format-card, .budget-card, .tactic-card, .step, .point').forEach(el => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(20px)';
    el.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
    observer.observe(el);
});

console.log('🚴 Vieux Hull Cycling Club - WTRL 2026');
console.log('Tokyo Night theme loaded');
console.log('Keyboard navigation: ← → ↑ ↓ keys, Home, End');
