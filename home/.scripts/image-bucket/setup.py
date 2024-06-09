from setuptools import setup, find_packages

setup(
    name="image-bucket",
    version="0.1",
    packages=find_packages(),
    install_requires=[
        'opencv-python==4.10.0.82',
    ],
    entry_points={
        'console_scripts': [
            'image-bucket = image-bucket.main:main',
        ],
    },
)
